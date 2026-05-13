// -----------------------------------------------------------------------------
// MedicationAdministration profiles
// -----------------------------------------------------------------------------

Profile: StrokeMedicationAdministrationProfile
Parent: MedicationAdministration
Id: stroke-medication-administration-profile
Title: "Stroke MedicationAdministration Profile"
Description: "Generic MedicationAdministration profile for acute stroke treatment medications, including thrombolysis, anticoagulant reversal, IV antihypertensives and other administrations."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-medication-administration-profile"
* insert RESQProfileMetadata
* ^purpose = "Records medication administrations that are part of the acute or post-acute stroke treatment pathway."
* status 1..1 MS
* status ^short = "Medication administration status"
* insert RESQPatientSubject
* insert RESQEncounterContext
* medication 1..1 MS
* medication from MedicationsVS (extensible)
* medication ^short = "Administered medication"
* occurence[x] 1..1 MS
* occurence[x] only Period or dateTime
* occurence[x] ^short = "Administration date/time"
* reason 0..* MS
* reason only CodeableReference(Condition or Observation)
* reason ^short = "Reason or clinical trigger for administration"
* partOf 0..* MS
* partOf only Reference(Procedure)
* partOf ^short = "Procedure this administration supports"
* dosage 0..1 MS
* dosage ^short = "Dose details"
* dosage.dose 0..1 MS
* statusReason 0..* MS
* statusReason from NotMedicationReasonVS (extensible)
* statusReason ^short = "Reason medication was not given or status rationale"
* extension contains RequiredPostAcuteCareExt named requiredPostAcuteCare 0..1 MS
  and AssessmentTimingExt named assessmentTiming 0..1 MS

Profile: ParacetamolOnFeverMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: paracetamol-on-fever-medicationAdministration-profile
Title: "Paracetamol on Fever MedicationAdministration Profile"
Description: "MedicationAdministration profile for paracetamol administered because of fever."
* ^url = "http://tecnomod-um.org/StructureDefinition/paracetamol-on-fever-medicationAdministration-profile"
* insert RESQProfileMetadata
* medication.concept = SCT#387517004 "Paracetamol (substance)"
* reason 1..* MS
* reason only CodeableReference(FeverObservationProfile)
* extension[assessmentTiming].valueCodeableConcept from ParacetamolOnFeverTimingVS (required)

Profile: InsulinOnHyperglycemiaMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: insulin-on-hyperglycemia-medicationAdministration-profile
Title: "Insulin on Hyperglycemia MedicationAdministration Profile"
Description: "MedicationAdministration profile for insulin administered in response to hyperglycemia."
* ^url = "http://tecnomod-um.org/StructureDefinition/insulin-on-hyperglycemia-medicationAdministration-profile"
* insert RESQProfileMetadata
* medication.concept = SCT#67866001 "Insulin (substance)"
* reason 1..* MS
* reason only CodeableReference(HighestHyperglycemiaValueObservationProfile or HyperglycemiaObservationProfile)
* extension[assessmentTiming].valueCodeableConcept from InsulinOnHyperglycemiaTimingVS (required)

Profile: NimodipineMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: nimodipine-medicationAdministration-profile
Title: "Nimodipine MedicationAdministration Profile"
Description: "MedicationAdministration profile for nimodipine in the subarachnoid hemorrhage pathway."
* ^url = "http://tecnomod-um.org/StructureDefinition/nimodipine-medicationAdministration-profile"
* insert RESQProfileMetadata
* medication.concept = SCT#387502003 "Nimodipine (substance)"
* reason 0..* MS
* extension contains AssessmentTimingExt named nimodipineTiming 0..1 MS
