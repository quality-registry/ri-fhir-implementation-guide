// -----------------------------------------------------------------------------
// Minimal example instances useful for smoke testing the profiles
// -----------------------------------------------------------------------------

Instance: ExampleRESQPatient
InstanceOf: RESQPatientProfile
Usage: #example
* identifier.value = "patient-001"
* extension[genderSnomed].valueCodeableConcept = SCT#248153007 "Male (finding)"

Instance: OrganizationExample
InstanceOf: Organization
Usage: #example
* identifier.value = "organization-001"
* name = "Example Healthcare Organization"

Instance: ExampleStrokeEncounter
InstanceOf: StrokeEncounterProfile
Usage: #example
* status = #completed
* subject = Reference(ExampleRESQPatient)
* extension[firstHospital].valueReference = Reference(OrganizationExample)
* extension[requiredPostAcuteCare].valueBoolean = false
* extension[emsPrenotification].valueBoolean = true
* admission.admitSource = StrokeArrivalModeCS#ems-gp "EMS from GP"
* admission.dischargeDisposition = SCT#306689006 "Discharge to home (procedure)"

Instance: ExampleStrokeDiagnosis
InstanceOf: StrokeDiagnosisConditionProfile
Usage: #example
* subject = Reference(ExampleRESQPatient)
* encounter = Reference(ExampleStrokeEncounter)
* clinicalStatus = ConditionClinicalCS#active "Active"
* verificationStatus = ConditionVerificationCS#confirmed "Confirmed"
* code = SCT#422504002 "Ischemic stroke (disorder)"
* extension[wakeupStroke].valueBoolean = false
* category = ConditionCategoryCS#encounter-diagnosis "Encounter Diagnosis"

Instance: ExampleDoorToNeedle
InstanceOf: TimingMetricObservationProfile
Usage: #example
* status = #final
* subject = Reference(ExampleRESQPatient)
* encounter = Reference(ExampleStrokeEncounter)
* code = TimingMetricCodesCS#D2N "Door to Needle"
* valueQuantity.value = 38
* valueQuantity.system = "https://ucum.org/ucum"
* valueQuantity.code = #min
* valueQuantity.unit = "minute"

// ----------------------------------------------------------------------------
// Example questionnaire responses
//
// Answers are taken from the documented RES-Q questionnaire service payloads in
// docs/example_requests.md. Note that valueCoding.system for the SF-SIS answers is
// the code system defined by this guide
// (http://tecnomod-um.org/CodeSystem/sf-sis-answers-cs); the service currently sends
// the legacy https://qualityregistry.org/fhir/code-system/sf-sis-answers instead.
//
// The SNOMED CT answer displays are the registry labels as the service sends them;
// five of them are not valid designations of their code and are reported by the FHIR
// validator. See the divergence table in questionnaires.fsh.
// ----------------------------------------------------------------------------

Instance: ExampleMrsResponse
InstanceOf: PatientReportedOutcomeQuestionnaireResponses
Usage: #example
Title: "ExampleMrsResponse"
Description: "Patient-reported mRS response following the yes/yes/yes path through the decision tree, which corresponds to a score of 0."
* questionnaire = Canonical(MrsQuestionnaire)
* status = #completed
* subject = Reference(ExampleRESQPatient)
* source = Reference(ExampleRESQPatient)
* authored = "2026-01-14T07:32:49.762Z"
* item[0].linkId = "mrs_q1"
* item[0].answer.valueBoolean = true
* item[1].linkId = "mrs_q2"
* item[1].answer.valueBoolean = true
* item[2].linkId = "mrs_q3"
* item[2].answer.valueBoolean = true

Instance: ExamplePhq9Response
InstanceOf: PatientReportedOutcomeQuestionnaireResponses
Usage: #example
Title: "ExamplePhq9Response"
Description: "Patient-reported PHQ-9 response with all nine items answered."
* questionnaire = Canonical(Phq9Questionnaire)
* status = #completed
* subject = Reference(ExampleRESQPatient)
* source = Reference(ExampleRESQPatient)
* authored = "2026-01-14T07:32:49.762Z"
* item[0].linkId = "phq9_q1"
* item[0].answer.valueCoding = SCT#260353006 "Not at all"
* item[1].linkId = "phq9_q2"
* item[1].answer.valueCoding = SCT#5878004 "Several days"
* item[2].linkId = "phq9_q3"
* item[2].answer.valueCoding = SCT#5878004 "Several days"
* item[3].linkId = "phq9_q4"
* item[3].answer.valueCoding = SCT#5878004 "Several days"
* item[4].linkId = "phq9_q5"
* item[4].answer.valueCoding = SCT#5878004 "Several days"
* item[5].linkId = "phq9_q6"
* item[5].answer.valueCoding = SCT#5878004 "Several days"
* item[6].linkId = "phq9_q7"
* item[6].answer.valueCoding = SCT#5878004 "Several days"
* item[7].linkId = "phq9_q8"
* item[7].answer.valueCoding = SCT#255218000 "More than half the days"
* item[8].linkId = "phq9_q9"
* item[8].answer.valueCoding = SCT#27732004 "Nearly every day"

Instance: ExampleSfSisResponse
InstanceOf: PatientReportedOutcomeQuestionnaireResponses
Usage: #example
Title: "ExampleSfSisResponse"
Description: "Patient-reported SF-SIS response with all eight items answered."
* questionnaire = Canonical(SfSisQuestionnaire)
* status = #completed
* subject = Reference(ExampleRESQPatient)
* source = Reference(ExampleRESQPatient)
* authored = "2026-01-14T07:32:49.762Z"
* item[0].linkId = "sfsis_q1"
* item[0].answer.valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[1].linkId = "sfsis_q2"
* item[1].answer.valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[2].linkId = "sfsis_q3"
* item[2].answer.valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[3].linkId = "sfsis_q4"
* item[3].answer.valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[4].linkId = "sfsis_q5"
* item[4].answer.valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[5].linkId = "sfsis_q6"
* item[5].answer.valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[6].linkId = "sfsis_q7"
* item[6].answer.valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[7].linkId = "sfsis_q8"
* item[7].answer.valueCoding = SfSisAnswersCS#3 "Somewhat difficult"

Instance: ExampleSfNeadlResponse
InstanceOf: PatientReportedOutcomeQuestionnaireResponses
Usage: #example
Title: "ExampleSfNeadlResponse"
Description: "Patient-reported SF-NEADL response with all five items answered."
* questionnaire = Canonical(SfNeadlQuestionnaire)
* status = #completed
* subject = Reference(ExampleRESQPatient)
* source = Reference(ExampleRESQPatient)
* authored = "2026-01-14T07:32:49.762Z"
* item[0].linkId = "sfneadl_q1"
* item[0].answer.valueCoding = SCT#371157007 "Independent with difficulty"
* item[1].linkId = "sfneadl_q2"
* item[1].answer.valueCoding = SCT#371157007 "Independent with difficulty"
* item[2].linkId = "sfneadl_q3"
* item[2].answer.valueCoding = SCT#371157007 "Independent with difficulty"
* item[3].linkId = "sfneadl_q4"
* item[3].answer.valueCoding = SCT#371157007 "Independent with difficulty"
* item[4].linkId = "sfneadl_q5"
* item[4].answer.valueCoding = SCT#371157007 "Independent with difficulty"
