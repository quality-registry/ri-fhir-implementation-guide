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

## Extensions

Extensions are used only where the base FHIR resource lacks an appropriate element or the source builder already emits a stable extension URL. Examples include first-hospital status, EMS prenotification, wake-up stroke, timing context and post-acute-care relevance.

## Terminology

Local registry enumerations are represented as CodeSystems and ValueSets under the IG canonical. This makes generated codes computable, reusable in bindings and visible in the published artifact index, while preserving external standards such as SNOMED CT, LOINC and UCUM when those are already appropriate.
