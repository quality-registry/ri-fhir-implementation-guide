# Modeling Decisions

This page explains the main modeling choices in the RES-Q FHIR IG. The goal is to make the generated resources easy to validate, clinically interpretable and close to the shape of the source transformation pipeline.

## Patient and Encounter

`Patient` is kept deliberately small. The registry does not need a full demographic record in the IG, so [RESQ Patient](StructureDefinition-resq-patient-profile.html) requires a stable identifier and carries sex/gender as a SNOMED CT coded extension. `Patient.gender` is prohibited so implementers do not send conflicting administrative and clinical sex/gender values.

The [Stroke Encounter](StructureDefinition-stroke-encounter-profile.html) is the central episode context. Most clinical resources require both `subject` and `encounter`, making it straightforward to query all facts for a stroke admission and to distinguish repeated admissions for the same patient.

## Conditions vs Observations

`Condition` is used when the registry concept is a clinical assertion that can persist over time: the index diagnosis, risk factors and complications. These profiles bind `code` to focused registry value sets and keep the diagnosis-specific details in extensions when the base Condition model has no clean field for them.

`Observation` is used for values, assessments and results: vital signs, functional scores, laboratory values, timing metrics, imaging findings and follow-up indicators. This keeps quantitative and coded results in the FHIR resource designed for measurement and assessment.

## Procedures and Reports

`Procedure` represents actions performed, planned, not performed or assessed in the pathway. The guide uses dedicated profiles for imaging, reperfusion, swallowing screening, VTE prophylaxis and selected treatments because each group carries different timing, reason, performer, report or not-done semantics.

`DiagnosticReport` groups results from imaging and mechanical thrombectomy. Reports link back to observations so consumers can read a report summary while still processing individual findings such as mTICI or carotid stenosis.

## Medication Resources

The model uses three medication resources because the registry captures three different meanings:

| Resource | Meaning in this IG |
| --- | --- |
| `MedicationStatement` | Medication use before the stroke, including adherence. |
| `MedicationRequest` | Discharge medication orders or recommendations. |
| `MedicationAdministration` | Medication actually administered as part of acute or post-acute stroke care. |

## Derived Values

The registry calculates figures from a patient's self-reported readings. Each
calculation is published as its own Observation rather than folded into the
readings, so it can be queried directly and the reasoning stays auditable.

One profile covers them all, whatever the analyte:

| Profile | States |
| --- | --- |
| [Self-Reported Value Aggregation](StructureDefinition-self-reported-value-aggregation-profile.html) | Figures the registry calculated from self-reported readings |

The aggregation the guide currently describes is blood pressure over a fixed
look-back window: average systolic pressure, average diastolic pressure, and the
proportion of readings that fell within target.

| Decision | Why |
| --- | --- |
| Parent is `BaseSelfReportedObservation`, not `BaseStrokeObservation` | The inputs are self-reported and carry no encounter, so neither can anything derived from them. |
| `code` is bound to its own value set | [ValueAggregation](ValueSet-self-reported-value-aggregation-vs.html) holds the calculated concepts and is kept apart from [SelfReportedSigns](ValueSet-self-reported-signs-vs.html), which holds only the readings, so a derived resource cannot carry a reading concept and a reading cannot carry a derived concept. |
| The verdict is `interpretation`, not a resource of its own | A control status is an interpretation of the data it was made from. Putting it on the aggregation keeps figures and verdict in one retrieval, and `interpretation` is `0..1` because the assessment is a single statement. |
| Each profile binds `interpretation` to its own value set | [SelfReportedAggregationStatus](ValueSet-self-reported-aggregation-status-vs.html) on the aggregation, [SelfReportedReadingStatus](ValueSet-self-reported-reading-status-vs.html) on the readings, so neither profile can carry the other's verdict. Both bindings are required, because the calculating service emits exactly these codes. |
| Two invariants narrow the readings binding to the analyte | `SelfReportedReadingStatus` spans both analyte systems, so the binding alone would let an LDL verdict sit on a glucose reading. `srvs-glucose-status-must-use-glucose-vs` and `srvs-ldl-status-must-use-cholesterol-vs` restrict `interpretation` to the system matching `Observation.code`, in the same guard-clause form the specific-finding profile already uses for coded values. |
| A figure is carried in either `value[x]` or components | The same choice `SelfReportedVitalSignsProfile` makes for the readings: several figures belonging to one aggregation go in components, as blood pressure is represented everywhere else in this guide, and a single derived number goes straight in `value[x]`. An invariant requires one of the two. |
| Components are `0..*`, bound to a value set and left unsliced | Consistent with the other component-bearing observation profiles. The unit each concept carries is stated as an invariant, as in the specific-finding profile, rather than as a fixed slice. Those invariants are conditional, so they bite only on a component that is present. |
| Time in range is one figure for the blood pressure as a whole | A reading counts as in range only when systolic and diastolic are both within target. A combined figure cannot be recomputed from separate systolic and diastolic percentages, so the combined form is the one recorded. |
| Time in range uses a local code | SNOMED CT International has no concept for blood-pressure time in range. |
| An aggregation references every reading it used | A calculated figure is only auditable if its inputs are reachable, so `derivedFrom` is `1..*`. |
| The window is both a coded extension and `effectivePeriod` | `effectivePeriod` carries the actual calendar days, which is what makes the figures reproducible; the extension carries 7-day / 14-day / 30-day as a code so consumers can select one window without date arithmetic. The two must agree - 7, 14 or 30 days counted inclusively - but no invariant enforces it, because FHIRPath has no portable way to express the length of a `Period`. The extension is `0..1`, since an aggregation that is not windowed has no window to state. |
| The numeric target is not carried anywhere | `target-adjusted-for-age` records that an age-adjusted target was applied, but not what it was. `Observation.referenceRange` is deliberately left unused. |
| Status codes are normalized to kebab-case | The calculating service emits them in an upper-case, underscore-separated form, but every other local CodeSystem in this guide uses lower-case kebab-case and `caseSensitive = false`. The codes are normalized on the way in, as the questionnaire service's observation codes already are, and the service must be migrated onto them for the two sides to agree at source. |

### Control statuses

Alongside the figures, the registry judges how well a patient controls their
blood pressure, glucose and LDL cholesterol. The judgement is not a resource of
its own: it is an interpretation of the data it was made from, so it is carried
in `Observation.interpretation`.

Which profile carries it follows from what the judgement is about, and the two
value sets keep the split enforceable:

| Judgement about | Lives on | Bound to |
| --- | --- | --- |
| Aggregated blood pressure | [Self-Reported Value Aggregation](StructureDefinition-self-reported-value-aggregation-profile.html), `0..1` | [SelfReportedAggregationStatus](ValueSet-self-reported-aggregation-status-vs.html) |
| A glucose or LDL reading | [Self-Reported Vital Signs](StructureDefinition-self-reported-vital-signs-profile.html), `0..*` | [SelfReportedReadingStatus](ValueSet-self-reported-reading-status-vs.html) |

Blood pressure appears only on the aggregation because its codes are statements
about an aggregate: they speak of the average and of repeated elevation across a
window, neither of which a single reading can support. Glucose and LDL
cholesterol are judged from the latest reading, so they sit on the reading
itself. `0..*` there because one reported observation can carry more than one
measurement; `0..1` on the aggregation, which states one figure or one set of
figures.

The three enumerations are separate CodeSystems, one per subject, so each is
free to change its own list and the two bindings above can be assembled from
whole systems rather than from hand-picked codes. Every code carries its subject
as a prefix - `bp-`, `glucose-`, `ldl-` - so an assessment that recurs across
subjects is spelled out separately in each: `glucose-within-target` and
`ldl-within-target`, never a bare `within-target` disambiguated only by its
system URL. A code therefore stays meaningful on its own in logs, queries and
generated enumerations, and the union in `SelfReportedReadingStatus` contains no
two members that differ only by system.

Each enumeration carries its own no-data code, and the three are deliberately
not synonyms. `bp-insufficient-data` means the averages and the time-in-range
percentage were computed and are present, but too few readings backed them for a
risk verdict to follow; there is data, just not enough of it. `glucose-value-missing`
and `ldl-value-missing` mean the stronger thing: no reading was available at all,
so there was nothing to assess. The wording is kept distinct because the two
situations are distinct - and because the second pair describes an absent value,
which is what `Observation.dataAbsentReason` exists for.

## Extensions

Extensions are used only where the base FHIR resource lacks an appropriate element or the source builder already emits a stable extension URL. Examples include first-hospital status, EMS prenotification, wake-up stroke, timing context and post-acute-care relevance.

## Terminology

Local registry enumerations are represented as CodeSystems and ValueSets under the IG canonical. This makes generated codes computable, reusable in bindings and visible in the published artifact index, while preserving external standards such as SNOMED CT, LOINC and UCUM when those are already appropriate.
