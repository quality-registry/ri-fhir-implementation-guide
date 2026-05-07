// -----------------------------------------------------------------------------
// Medication profiles
// -----------------------------------------------------------------------------

Profile: PriorMedicationStatementProfile
Parent: MedicationStatement
Id: prior-medication-statement-profile
Title: "Prior MedicationStatement Profile"
Description: "MedicationStatement profile for medication taken before stroke onset, aligned with build_before_onset_medicationStatement_profile()."
* ^url = "http://tecnomod-um.org/StructureDefinition/prior-medication-statement-profile"
* status 1..1 MS
* status = #recorded
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* medication 1..1 MS
* medication from MedicationsVS (extensible)
* adherence 1..1 MS
* adherence.code 1..1 MS
* adherence.code from AdherenceCodesVS (required)

Profile: DischargeMedicationRequestProfile
Parent: MedicationRequest
Id: discharge-medication-request-profile
Title: "Discharge MedicationRequest Profile"
Description: "MedicationRequest profile for medications prescribed at discharge, aligned with build_on_discharge_medicationRequest_profile()."
* ^url = "http://tecnomod-um.org/StructureDefinition/discharge-medication-request-profile"
* status 1..1 MS
* status = #active
* intent 1..1 MS
* intent = #order
* category 1..* MS
* category = MedicationRequestAdminLocationCS#community
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* medication 1..1 MS
* medication 1..1 MS
* medication from DischargeMedicationVS (extensible)

Profile: StrokeMedicationAdministrationProfile
Parent: MedicationAdministration
Id: stroke-medication-administration-profile
Title: "Stroke MedicationAdministration Profile"
Description: "Generic MedicationAdministration profile for acute stroke treatment medications, including thrombolysis, anticoagulant reversal, IV antihypertensives and other administrations."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-medication-administration-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* medication 1..1 MS
* medication from MedicationsVS (extensible)
* occurence[x] 1..1 MS
* occurence[x] only dateTime
* reason 0..* MS
* reason only CodeableReference(Condition or Observation)
* partOf 0..* MS
* partOf only Reference(Procedure)
* dosage 0..1 MS
* dosage.dose 0..1 MS
* statusReason 0..* MS
* statusReason from NotMedicationReasonVS (extensible)
* extension contains RequiredPostAcuteCareExt named requiredPostAcuteCare 0..1 MS
  and AssessmentTimingExt named assessmentTiming 0..1 MS

Profile: ParacetamolOnFeverMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: paracetamol-on-fever-medicationAdministration-profile
Title: "Paracetamol on Fever MedicationAdministration Profile"
Description: "MedicationAdministration profile for paracetamol given because of fever."
* ^url = "http://tecnomod-um.org/StructureDefinition/paracetamol-on-fever-medicationAdministration-profile"
* medication.concept = SCT#387517004 "Paracetamol (substance)"
* reason 1..* MS
* reason only CodeableReference(FeverObservationProfile)
* extension[assessmentTiming].valueCodeableConcept from ParacetamolOnFeverTimingVS (required)

Profile: InsulinOnHyperglycemiaMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: insulin-on-hyperglycemia-medicationAdministration-profile
Title: "Insulin on Hyperglycemia MedicationAdministration Profile"
Description: "MedicationAdministration profile for insulin administered due to hyperglycemia."
* ^url = "http://tecnomod-um.org/StructureDefinition/insulin-on-hyperglycemia-medicationAdministration-profile"
* medication.concept = SCT#67866001 "Insulin (substance)"
* reason 1..* MS
* reason only CodeableReference(HighestHyperglycemiaValueObservationProfile or HyperglycemiaObservationProfile)
* extension contains AssessmentTimingExt named insulinTiming 0..1 MS
* extension[insulinTiming].valueCodeableConcept from InsulinOnHyperglycemiaTimingVS (required)

Profile: NimodipineMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: nimodipine-medicationAdministration-profile
Title: "Nimodipine MedicationAdministration Profile"
Description: "MedicationAdministration profile for nimodipine in subarachnoid hemorrhage pathway."
* ^url = "http://tecnomod-um.org/StructureDefinition/nimodipine-medicationAdministration-profile"
* medication.concept = SCT#387502003 "Nimodipine (substance)"
* reason 0..* MS
* extension contains AssessmentTimingExt named nimodipineTiming 0..1 MS
