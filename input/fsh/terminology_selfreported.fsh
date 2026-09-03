// -----------------------------------------------------------------------------
// Terminology for patient-reported observations
//
// Hand-authored, deliberately kept out of terminology_generated.fsh so a
// regeneration from enum_models.py cannot clobber it.
//
// The codes below are the ones the RES-Q questionnaire service actually posts,
// taken from its published observation-code table in docs/example_requests.md
// and from the worked payload for each code in the same document.
//
// The service publishes SNOMED CT UK Edition codes for glucose, LDL cholesterol
// and glycated haemoglobin (1018851000000108, 1022191000000100 and
// 1019431000000105). None of the three exists in the International Edition this
// guide validates against, so they are replaced here by International concepts,
// and glucose and LDL now use the same codes as in-hospital analytics in
// AnalyticsCodesVS. The questionnaire service must be migrated onto these codes
// for the two sides to agree at source.
//
// Body mass index is absent on purpose. The questionnaire service has no BMI
// code, so the guide does not yet describe one; adding it later is one line.
// -----------------------------------------------------------------------------

ValueSet: SelfReportedSignsVS
Id: self-reported-signs-vs
Title: "SelfReportedSigns ValueSet"
Description: "Measurements a patient reports about themselves through the RES-Q questionnaire service: blood pressure and its components, glucose, LDL cholesterol, glycated haemoglobin, weight and height."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-signs-vs"
* ^status = #active
* ^experimental = false
* include SCT#75367002 "Blood pressure (observable entity)"
* include SCT#271649006 "Systolic blood pressure (observable entity)"
* include SCT#271650006 "Diastolic blood pressure (observable entity)"
* include SCT#33747003 "Glucose measurement, blood (procedure)"
* include SCT#372361000119104 "Low density lipoprotein cholesterol by direct assay (observable entity)"
* include SCT#43396009 "Hemoglobin A1c measurement (procedure)"
* include SCT#27113001 "Body weight (observable entity)"
* include SCT#1153637007 "Body height (observable entity)"

ValueSet: SelfReportedScoresVS
Id: self-reported-scores-vs
Title: "SelfReportedScores ValueSet"
Description: "Summary scores derived from the four patient-reported questionnaires the RES-Q questionnaire service collects. mRS and PHQ-9 have SNOMED CT concepts; the two short-form instruments do not, and reuse the local questionnaire codes that also identify the Questionnaire itself."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-scores-vs"
* ^status = #active
* ^experimental = false
* include SCT#1255866005 "Modified Rankin Scale score (observable entity)"
* include SCT#720433000 "Patient health questionnaire 9 (assessment scale)"
* include RESQQuestionnairesCS#sfneadl "short-form Nottingham Extended Activities of Daily Living"
* include RESQQuestionnairesCS#sfsis "short-form Stroke Impact Scale"
