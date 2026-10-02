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
| `interpretation` uses standard HL7 codes | Both profiles bind `interpretation` (required) to [SelfReportedInterpretation](ValueSet-self-reported-interpretation-vs.html): `HH` critical high, `HU` significantly high, `H` high, `N` normal, `L` low, `LU` significantly low, `LL` critical low and `IND` indeterminate from the HL7 [ObservationInterpretation](https://terminology.hl7.org/CodeSystem-v3-ObservationInterpretation.html) code system. Any consumer that understands interpretation flags can read the verdict without registry-specific terminology, and the analyte it applies to is already given by `Observation.code`. |
| A figure is carried in either `value[x]` or components | The same choice `SelfReportedVitalSignsProfile` makes for the readings: several figures belonging to one aggregation go in components, as blood pressure is represented everywhere else in this guide, and a single derived number goes straight in `value[x]`. An invariant requires one of the two. |
| Components are `0..*`, bound to a value set and left unsliced | Consistent with the other component-bearing observation profiles. The unit each concept carries is stated as an invariant, as in the specific-finding profile, rather than as a fixed slice. Those invariants are conditional, so they bite only on a component that is present. |
| Time in range is one figure for the blood pressure as a whole | A reading counts as in range only when systolic and diastolic are both within target. A combined figure cannot be recomputed from separate systolic and diastolic percentages, so the combined form is the one recorded. |
| Time in range uses a local code | SNOMED CT International has no concept for blood-pressure time in range. |
| An aggregation states how many readings it used | The required `numberOfMeasurements` extension records how many readings the figures were calculated from. |
| An aggregation states whether its criteria were adjusted for age | The patient's age is not on the Observation, so the required `adjustedInterpretationForAge` boolean extension records which rows of the assessment applied: `true` for patients aged 85 and over, `false` under 85. |
| The window is both a `Duration` extension and `effectivePeriod` | `effectivePeriod` carries the actual calendar days, which is what makes the figures reproducible; the extension carries the nominal window as a `Duration` - 30 days, 12 weeks - so consumers can select one window without date arithmetic. `Duration` is used in preference to a fixed code list so that any look-back length can be stated, and because the datatype already requires a UCUM time unit through its own `drt-1` invariant. The two must agree - the window counted inclusively over the period - but no invariant enforces it, because FHIRPath has no portable way to express the length of a `Period`. The extension is `1..1`: every aggregation states its window. |
| The numeric target is not carried anywhere | The interpretation flag records how the figures compare with the target, but not what the target was. `Observation.referenceRange` is deliberately left unused. |

### Control statuses

Alongside the figures, the registry judges how well a patient controls their
blood pressure, glucose and LDL cholesterol. The judgement is not a resource of
its own: it is an interpretation of the data it was made from, so it is carried
in `Observation.interpretation`.

Both profiles use the same standard HL7 interpretation flags, bound to
[SelfReportedInterpretation](ValueSet-self-reported-interpretation-vs.html):

| Code | Display |
| --- | --- |
| `HH` | Critical high: reserved for critical values |
| `HU` | Significantly high |
| `H` | High |
| `N` | Normal |
| `L` | Low |
| `LU` | Significantly low |
| `LL` | Critical low: reserved for critical values |
| `IND` | Indeterminate: the data was assessed but is not interpreted, for example too few readings in the window or low confidence in the values |

| Judgement about | Lives on |
| --- | --- |
| Aggregated blood pressure | [Self-Reported Value Aggregation](StructureDefinition-self-reported-value-aggregation-profile.html), `0..1` |
| A glucose or LDL reading | [Self-Reported Vital Signs](StructureDefinition-self-reported-vital-signs-profile.html), `0..*` |

Blood pressure is judged from the aggregate, glucose and LDL cholesterol from
the latest reading. `0..*` on the reading because one reported observation can
carry more than one measurement; `0..1` on the aggregation, which states one
figure or one set of figures. The flag carries no analyte of its own: what it
applies to is given by `Observation.code`. When no assessment was made at all,
`interpretation` is left out rather than coded.

### Assessment criteria

The criteria behind each interpretation are published as ObservationDefinitions,
one band per `qualifiedValue`, with the interpretation code a band produces in
the [Qualified value interpretation](StructureDefinition-qualified-value-interpretation-ext.html)
extension. Every band includes its lower bound and excludes its upper bound, so
each band's upper bound equals the next band's lower bound exactly.

| Measurement | ObservationDefinition |
| --- | --- |
| Glucose reading | [Self-Reported Glucose Assessment](ObservationDefinition-self-reported-glucose-assessment.html) |
| LDL cholesterol reading | [Self-Reported LDL Cholesterol Assessment](ObservationDefinition-self-reported-ldl-cholesterol-assessment.html) |
| Aggregated blood pressure | [Self-Reported Blood Pressure Assessment](ObservationDefinition-self-reported-blood-pressure-assessment.html) |
| mRS score, hospital or patient-reported | [Modified Rankin Scale Severity Assessment](ObservationDefinition-mrs-severity-assessment.html) |
| PHQ-9 score | [PHQ-9 Severity Assessment](ObservationDefinition-phq9-severity-assessment.html) |

Blood pressure is judged on the systolic and diastolic averages together, which
an ObservationDefinition cannot state: each component carries its own bands and
there is no element for combining them. The tables are "the more severe of the
two component bands", in the order `HU`, `H`, `N`. Diastolic pressure below
80 mmHg is within target and has no `L` band, so below target the systolic
average alone decides between `N` and `L`. Each component is banded on its own
and the combination rule is written in the definition.

One definition covers both age groups: every band carries `qualifiedValue.age`,
and the assessment table has an age column, with the treatment target adjusted
for patients aged 85 and over. The aggregation records which rows applied in the
required [Adjusted interpretation for age](StructureDefinition-adjusted-interpretation-for-age-ext.html)
extension.

A second table in the same definition states the critical rule: at least two
individual readings with systolic pressure of 180 mmHg or more, or diastolic
pressure of 110 mmHg or more, within 48 hours make the interpretation `HH`. It
counts readings over time, which an ObservationDefinition cannot express, so it
is published in the definition's table only.

No invariant recomputes the interpretation on the Observation: the criteria are
published in the definitions, and applying them is left to the registry.

## Scores

Every score the registry records, whether captured in hospital
([Functional Score Observation](StructureDefinition-functional-score-observation-profile.html))
or computed from a patient-reported questionnaire
([Self-Reported Functional Scores](StructureDefinition-self-reported-functional-scores-profile.html)),
is carried the same way, so a consumer reads every score with one rule.

| Decision | Why |
| --- | --- |
| A score is a `valueQuantity` in the UCUM unit `{score}` | One representation for every instrument: mRS, NIHSS, ASPECTS, Hunt-Hess, ICH score, ABCD2, CHA2DS2-VASc and THRIVE in hospital, and mRS, PHQ-9, short-form NEADL and short-form SIS reported by the patient. mRS used to be coded from a local code system as well; it is now a number like every other score. `{score}` is a UCUM annotation, so the unit is dimensionless but still states what the number is. |
| A score is a non-negative whole number | Every instrument is an integer scale. The self-reported profile fixes the unit and an invariant requires a whole number; on the hospital profile, whose `value[x]` stays open because the Glasgow Coma profiles derive from it, the `functional-score-value-quantity` invariant requires the same for each score instrument by its `Observation.code`. |
| Severity is `interpretation`, using SNOMED CT qualifiers | A score states how severe a condition is, which the HL7 low / normal / high flags cannot express. Both score profiles bind `interpretation` (required) to [ScoreSeverityInterpretation](ValueSet-score-severity-interpretation-vs.html): not significant, mild, mild to moderate, moderate, moderate to severe, severe and dead. |
| Severity is assessed for mRS and PHQ-9 | Their criteria are published as ObservationDefinitions, listed above, and the scored Observation points to the one it was assessed against in `instantiatesCanonical`. Other scores carry no interpretation. |
| A definition applies wherever its score is recorded | The definitions are keyed on `Observation.code` alone, so the mRS definition covers the pre-stroke, discharge and three-month hospital scores as well as the patient-reported one. |
| Score bands are bounded by the ends of the scale | `qualifiedValue` can express only a range, so a band holding the single score n is written, with the half-open convention above, as the range from n to n + 1. Unlike the reading definitions, the outermost bands are bounded too (mRS 0 to 6, PHQ-9 0 to 27), so every band names the exact scores it holds and a score outside the scale is not interpreted. |

## Extensions

Extensions are used only where the base FHIR resource lacks an appropriate element or the source builder already emits a stable extension URL. Examples include first-hospital status, EMS prenotification, wake-up stroke, timing context and post-acute-care relevance.

## Terminology

Local registry enumerations are represented as CodeSystems and ValueSets under the IG canonical. This makes generated codes computable, reusable in bindings and visible in the published artifact index, while preserving external standards such as SNOMED CT, LOINC and UCUM when those are already appropriate.
