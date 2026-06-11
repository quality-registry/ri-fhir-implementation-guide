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
