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
* admission.admitSource = StrokeArrivalModeCS#ems-gp "patient arrived by EMS/ambulance from general practitioner/outpatient office/community service"
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
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #min
* valueQuantity.unit = "minute"

// ----------------------------------------------------------------------------
// Example questionnaire responses
//
// Answers are taken from the documented RES-Q questionnaire service payloads in
// docs/example_requests.md. Note that valueCoding.system for the SF-SIS answers is
// the code system defined by this guide
// (http://fhir.qualityregistry.org/CodeSystem/sf-sis-answers-cs); the service currently sends
// the legacy https://qualityregistry.org/fhir/code-system/sf-sis-answers instead.
//
// The SNOMED CT answer displays are valid designations of their codes, which differ
// from the registry labels the service sends today. See the divergence table in
// questionnaires.fsh for the mapping.
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
* item[0].answer.valueCoding = SCT#260353006 "Nothing at all"
* item[1].linkId = "phq9_q2"
* item[1].answer.valueCoding = SCT#5878004 "Low frequency"
* item[2].linkId = "phq9_q3"
* item[2].answer.valueCoding = SCT#5878004 "Low frequency"
* item[3].linkId = "phq9_q4"
* item[3].answer.valueCoding = SCT#5878004 "Low frequency"
* item[4].linkId = "phq9_q5"
* item[4].answer.valueCoding = SCT#5878004 "Low frequency"
* item[5].linkId = "phq9_q6"
* item[5].answer.valueCoding = SCT#5878004 "Low frequency"
* item[6].linkId = "phq9_q7"
* item[6].answer.valueCoding = SCT#5878004 "Low frequency"
* item[7].linkId = "phq9_q8"
* item[7].answer.valueCoding = SCT#255218000 "Mid-frequency"
* item[8].linkId = "phq9_q9"
* item[8].answer.valueCoding = SCT#27732004 "High frequency"

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
* item[0].answer.valueCoding = SCT#371157007 "Able with difficulty"
* item[1].linkId = "sfneadl_q2"
* item[1].answer.valueCoding = SCT#371157007 "Able with difficulty"
* item[2].linkId = "sfneadl_q3"
* item[2].answer.valueCoding = SCT#371157007 "Able with difficulty"
* item[3].linkId = "sfneadl_q4"
* item[3].answer.valueCoding = SCT#371157007 "Able with difficulty"
* item[4].linkId = "sfneadl_q5"
* item[4].answer.valueCoding = SCT#371157007 "Able with difficulty"

// ----------------------------------------------------------------------------
// Example self-reported medication note
//
// Values are taken from the questionnaire service's own MedicationStatement test
// fixture (apps/questionnaire_app/tests/test_medication.py), with two deliberate
// departures:
//
//   1. The fixture sends medication.codable.coding SCT#318341000 alongside the
//      text. This profile prohibits the Coding, so only the text is carried.
//   2. The fixture also sends medication.ingredient (Atorvastatin, 20 mg). Ingredients
//      belong to a Medication resource, which this profile forbids by closing
//      medication.reference, so they are not carried as a separate element. Nothing
//      is lost: the strength is already part of the text the patient wrote, which by
//      convention reads name + strength + form, as it does here.
//
// The encounter is deliberately absent, which is the normal case for these notes.
// ----------------------------------------------------------------------------

Instance: ExampleSelfReportedMedicationNote
InstanceOf: SelfReportedMedicationStatementProfile
Usage: #example
Title: "ExampleSelfReportedMedicationNote"
Description: "Patient-reported statin taken one tablet each evening for two months."
* identifier[0].system = "http://fhir.qualityregistry.org/identifier/medication-statement-resource-id"
* identifier[0].value = "medication-001"
* status = #recorded
* subject = Reference(ExampleRESQPatient)
* informationSource = Reference(ExampleRESQPatient)
* medication.concept.text = "Atorvastatin 20 mg tablet"
* dateAsserted = "2026-01-20T07:17:19.921Z"
* effectivePeriod.start = "2026-01-20"
* effectivePeriod.end = "2026-03-20"
* dosage[0].asNeeded = false
* dosage[0].timing.repeat.frequency = 1
* dosage[0].timing.repeat.period = 1
* dosage[0].timing.repeat.periodUnit = #d
* dosage[0].timing.repeat.when[0] = #EVE
* dosage[0].doseAndRate[0].doseQuantity.value = 1
* dosage[0].doseAndRate[0].doseQuantity.system = "http://fhir.qualityregistry.org/CodeSystem/dose-form-unit-cs"
* dosage[0].doseAndRate[0].doseQuantity.code = #tablet
* dosage[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* note[0].text = "Take after dinner"

// ----------------------------------------------------------------------------
// Example patient-reported observations
//
// Values and shapes are taken from the RES-Q questionnaire service payloads in
// docs/example_requests.md. None of them carries an encounter, and all are
// posted as registered, which is what BaseSelfReportedObservation allows.
//
// The two vital-sign examples cover both branches of srvs-value-or-component:
// blood pressure carries components and no top-level value, glucose the reverse.
//
// valueQuantity.system is the UCUM canonical http://unitsofmeasure.org, which is
// also what the questionnaire service sends.
// ----------------------------------------------------------------------------

Instance: ExampleSelfReportedBloodPressure
InstanceOf: SelfReportedVitalSignsProfile
Usage: #example
Title: "ExampleSelfReportedBloodPressure"
Description: "Blood pressure the patient reports from home monitoring, carried as systolic and diastolic components with no top-level value."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#75367002 "Blood pressure (observable entity)"
* issued = "2026-01-20T07:17:19.921Z"
* component[0].code = SCT#271649006 "Systolic blood pressure (observable entity)"
* component[0].valueQuantity.value = 120
* component[0].valueQuantity.unit = "mmHg"
* component[0].valueQuantity.system = "http://unitsofmeasure.org"
* component[0].valueQuantity.code = #mm[Hg]
* component[1].code = SCT#271650006 "Diastolic blood pressure (observable entity)"
* component[1].valueQuantity.value = 80
* component[1].valueQuantity.unit = "mmHg"
* component[1].valueQuantity.system = "http://unitsofmeasure.org"
* component[1].valueQuantity.code = #mm[Hg]

Instance: ExampleSelfReportedGlucose
InstanceOf: SelfReportedVitalSignsProfile
Usage: #example
Title: "ExampleSelfReportedGlucose"
Description: "Glucose level the patient reports, carried as a single value with no components, with the registry's assessment of it."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#33747003 "Glucose measurement, blood (procedure)"
* issued = "2026-01-20T07:17:19.921Z"
* interpretation = GlucoseRiskStatusCS#below-target-hypoglycemia-risk "Below target, hypoglycemia risk"
* valueQuantity.value = 1.8
* valueQuantity.unit = "milligrams per deciliter"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #mg/dL

Instance: ExampleSelfReportedMrsScore
InstanceOf: SelfReportedFunctionalScoresProfile
Usage: #example
Title: "ExampleSelfReportedMrsScore"
Description: "Modified Rankin Scale score computed from the patient's own answers, linked back to the QuestionnaireResponse it was derived from."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#1255866005 "Modified Rankin Scale score (observable entity)"
* issued = "2026-01-20T07:17:19.921Z"
* valueInteger = 1
* derivedFrom = Reference(ExampleMrsResponse)

// ----------------------------------------------------------------------------
// Example derived observation
//
// A 30-day average calculated from the patient's own readings, with the
// registry's assessment of those figures in interpretation. Only two source
// readings are referenced here because the guide defines only two self-reported
// blood-pressure examples; a real 30-day average would reference many more.
// ----------------------------------------------------------------------------

Instance: ExampleSelfReportedBloodPressureAverage30Day
InstanceOf: SelfReportedValueAggregationProfile
Usage: #example
Title: "ExampleSelfReportedBloodPressureAverage30Day"
Description: "Thirty-day average of the patient's self-reported blood pressure, with the proportion of readings that fell within target and the registry's assessment of those figures."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#723232008 "Average blood pressure (observable entity)"
* category = ObservationCategoryCS#vital-signs
* extension[averagingWindow].valueCodeableConcept = AveragingWindowCS#30-day "30-day window"
* effectivePeriod.start = "2025-12-22"
* effectivePeriod.end = "2026-01-20"
* issued = "2026-01-21T02:00:00.000Z"
* interpretation = BloodPressureRiskStatusCS#above-esc-treatment-target "Above ESC treatment target"
* derivedFrom[0] = Reference(ExampleSelfReportedBloodPressure)
* derivedFrom[1] = Reference(ExampleSelfReportedBloodPressureLater)
* component[0].code = SCT#314440001 "Average systolic blood pressure (observable entity)"
* component[0].valueQuantity.value = 128.5
* component[0].valueQuantity.unit = "mmHg"
* component[0].valueQuantity.system = "http://unitsofmeasure.org"
* component[0].valueQuantity.code = #mm[Hg]
* component[1].code = SCT#314453003 "Average diastolic blood pressure (observable entity)"
* component[1].valueQuantity.value = 83
* component[1].valueQuantity.unit = "mmHg"
* component[1].valueQuantity.system = "http://unitsofmeasure.org"
* component[1].valueQuantity.code = #mm[Hg]
* component[2].code = DerivedObservationCS#bp-time-in-range "Blood pressure time in range"
* component[2].valueQuantity.value = 50
* component[2].valueQuantity.unit = "%"
* component[2].valueQuantity.system = "http://unitsofmeasure.org"
* component[2].valueQuantity.code = #"%"

Instance: ExampleSelfReportedBloodPressureLater
InstanceOf: SelfReportedVitalSignsProfile
Usage: #example
Title: "ExampleSelfReportedBloodPressureLater"
Description: "A second self-reported blood-pressure reading, above target, so the derived average has more than one input to reference."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#75367002 "Blood pressure (observable entity)"
* issued = "2026-01-18T07:05:11.000Z"
* component[0].code = SCT#271649006 "Systolic blood pressure (observable entity)"
* component[0].valueQuantity.value = 137
* component[0].valueQuantity.unit = "mmHg"
* component[0].valueQuantity.system = "http://unitsofmeasure.org"
* component[0].valueQuantity.code = #mm[Hg]
* component[1].code = SCT#271650006 "Diastolic blood pressure (observable entity)"
* component[1].valueQuantity.value = 86
* component[1].valueQuantity.unit = "mmHg"
* component[1].valueQuantity.system = "http://unitsofmeasure.org"
* component[1].valueQuantity.code = #mm[Hg]

Instance: ExampleSelfReportedLdlCholesterol
InstanceOf: SelfReportedVitalSignsProfile
Usage: #example
Title: "ExampleSelfReportedLdlCholesterol"
Description: "LDL cholesterol level the patient reports, carried as a single value with no components, with the registry's assessment of it."
* status = #final
* subject = Reference(ExampleRESQPatient)
* code = SCT#372361000119104 "Low density lipoprotein cholesterol by direct assay (observable entity)"
* issued = "2026-01-20T07:17:19.921Z"
* interpretation = CholesterolRiskStatusCS#above-recommended-target "Above recommended target"
* valueQuantity.value = 3.4
* valueQuantity.unit = "millimoles per litre"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #mmol/L
