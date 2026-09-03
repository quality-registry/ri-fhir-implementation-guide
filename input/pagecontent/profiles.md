# Profiles

Profiles are grouped below by FHIR resource type. Each link opens the generated StructureDefinition page with the formal constraints, bindings, snapshots and downloadable JSON/XML/TTL representations.

## Administrative Resources

| Resource | Profiles |
| --- | --- |
| `Patient` | [RESQ Patient](StructureDefinition-resq-patient-profile.html) |
| `Encounter` | [Stroke Encounter](StructureDefinition-stroke-encounter-profile.html) |
| `Organization` | [Stroke Registry Organization](StructureDefinition-stroke-registry-organization-profile.html) |
| `Location` | [RESQ Location](StructureDefinition-resq-location-profile.html), [Hospitalized Location](StructureDefinition-hospitalized-location-profile.html) |
| `BodyStructure` | [RESQ BodyStructure](StructureDefinition-resq-body-structure-profile.html) |
| `PractitionerRole` | [RESQ PractitionerRole](StructureDefinition-resq-practitioner-role-profile.html) |

## Conditions

| Profile | Why it exists |
| --- | --- |
| [Stroke Diagnosis Condition](StructureDefinition-stroke-diagnosis-condition-profile.html) | Captures the index stroke diagnosis, onset, body site and stroke-specific classification details. |
| [Stroke Risk Factor Condition](StructureDefinition-stroke-risk-factor-condition-profile.html) | Represents comorbidities and risk factors relevant to stroke quality measurement. |
| [Post-Stroke Complication Condition](StructureDefinition-post-stroke-complication-condition-profile.html) | Records complications occurring after the index stroke. |

## Observations {#observations}

| Profile | Why it exists |
| --- | --- |
| [Base Stroke Observation](StructureDefinition-base-stroke-observation.html) | Shared subject, encounter, status and code constraints for registry observations. |
| [Base Self-Reported Observation](StructureDefinition-base-self-reported-observation.html) | Shared scaffold for patient-reported observations. Unlike the base above it does not require an encounter and does not fix status to final. |
| [Self-Reported Vital Signs](StructureDefinition-self-reported-vital-signs-profile.html) | Blood pressure, glucose, LDL cholesterol, glycated haemoglobin, weight and height as the patient reports them. |
| [Self-Reported Functional Scores](StructureDefinition-self-reported-functional-scores-profile.html) | Summary score of a patient-reported questionnaire, linked to the QuestionnaireResponse it was derived from. |
| [Vital Sign Observation](StructureDefinition-vital-sign-observation-profile.html) | Blood pressure and other vital signs using components. |
| [Functional Score Observation](StructureDefinition-functional-score-observation-profile.html) | NIHSS, mRS, ASPECTS and other severity or outcome scales. |
| [Glasgow Coma Scale Observation](StructureDefinition-glasgow-coma-scale-observation-profile.html) | Specialized GCS score binding. |
| [Specific Finding Observation](StructureDefinition-specific-finding-observation-profile.html) | Imaging, procedure and clinical findings such as mTICI or stenosis. |
| [Timing Metric Observation](StructureDefinition-timing-metric-observation-profile.html) | Door-to-needle, onset-to-door and related process metrics. |
| [Analytics Observation](StructureDefinition-analytics-observation-profile.html) | Laboratory and analytics values such as glucose, LDL and INR. |
| [Fever Observation](StructureDefinition-fever-observation-profile.html) | Fever indicator or temperature value. |
| [Hyperglycemia Observation](StructureDefinition-hyperglycemia-observation-profile.html) | Hyperglycemia checks and values. |
| [Glucose >= 10 Observation](StructureDefinition-glucose-ge10-observation-profile.html) | Boolean glucose threshold indicator. |
| [Highest Hyperglycemia Value Observation](StructureDefinition-highest-hyperglycemia-value-observation-profile.html) | Highest recorded glucose value in context. |
| [TIA Clinical Symptoms Observation](StructureDefinition-tia-clinical-symptoms-observation-profile.html) | TIA symptom indicators and durations. |
| [Patient Ventilated Observation](StructureDefinition-patient-ventilated-observation-profile.html) | Ventilation indicator. |
| [Three-Month Contact Mode Observation](StructureDefinition-three-month-contact-mode-observation-profile.html) | Contact mode used for follow-up outcome capture. |

## Procedures {#procedures}

| Profile | Why it exists |
| --- | --- |
| [Stroke Imaging Procedure](StructureDefinition-stroke-imaging-procedure-profile.html) | Brain imaging procedure and related report link. |
| [Stroke Carotid Imaging Procedure](StructureDefinition-stroke-carotid-imaging-procedure-profile.html) | Carotid imaging in post-stroke assessment. |
| [Stroke Carotid Endarterectomy Procedure](StructureDefinition-stroke-carotid-endarterectomy-procedure-profile.html) | Carotid intervention and timing window. |
| [Stroke Reperfusion Procedure](StructureDefinition-stroke-mechanical-procedure-profile.html) | Thrombolysis and mechanical thrombectomy, including not-done reasons. |
| [Stroke Swallowing Screening Procedure](StructureDefinition-stroke-swallow-procedure-profile.html) | Swallowing screening performer, timing and not-done reason. |
| [Stroke VTE Prophylaxis Procedure](StructureDefinition-stroke-vte-procedure-profile.html) | VTE prophylaxis in the stroke pathway. |
| [Stroke Treatment Procedure](StructureDefinition-stroke-treatment-procedure-profile.html) | Broader treatment and rehabilitation procedures. |

## Patient-Reported Outcomes {#patient-reported-outcomes}

| Profile | Why it exists |
| --- | --- |
| [Patient Reported Outcome Questionnaires](StructureDefinition-patient-reported-outcome-questionnaires.html) | Fixes the shape shared by the four registry instruments: a fully identified and versioned definition, a coded instrument identifier, and a flat list of coded, required, non-repeating questions. |
| [Patient Reported Outcome Questionnaire Responses](StructureDefinition-patient-reported-outcome-questionnaire-responses.html) | Constrains answers to the shape the registry collects, restricts the answered questionnaire to the four defined here, and flags skipped questions rather than omitting them. |

The four instrument definitions themselves are published as definitional `Questionnaire` instances: [mRS](Questionnaire-mrs-questionnaire.html), [PHQ-9](Questionnaire-phq9-questionnaire.html), [SF-SIS](Questionnaire-sf-sis-questionnaire.html) and [SF-NEADL](Questionnaire-sf-neadl-questionnaire.html).

## Reports

| Resource | Profiles |
| --- | --- |
| `DiagnosticReport` | [Stroke Imaging DiagnosticReport](StructureDefinition-stroke-imaging-diagnostic-report-profile.html), [Mechanical Thrombectomy DiagnosticReport](StructureDefinition-mechanical-thrombectomy-diagnostic-report-profile.html) |

## Medications {#medications}

| Resource | Profiles |
| --- | --- |
| `MedicationStatement` | [Prior MedicationStatement](StructureDefinition-prior-medication-statement-profile.html), [Self-Reported MedicationStatement](StructureDefinition-self-reported-medication-statement-profile.html) |
| `MedicationRequest` | [Discharge MedicationRequest](StructureDefinition-discharge-medication-request-profile.html) |
| `MedicationAdministration` | [Stroke MedicationAdministration](StructureDefinition-stroke-medication-administration-profile.html), [Paracetamol on Fever](StructureDefinition-paracetamol-on-fever-medication-administration-profile.html), [Insulin on Hyperglycemia](StructureDefinition-insulin-on-hyperglycemia-medication-administration-profile.html), [Nimodipine](StructureDefinition-nimodipine-medication-administration-profile.html) |
