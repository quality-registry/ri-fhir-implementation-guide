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

* obeys medadm-not-done-must-have-status-reason
* obeys medadm-status-reason-only-when-not-done

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

* extension contains
    RequiredPostAcuteCareExt named requiredPostAcuteCare 0..1 MS and
    AssessmentTimingExt named assessmentTiming 0..1 MS

* extension[requiredPostAcuteCare] ^short = "Whether the medication relates to post-acute care"
* extension[assessmentTiming] ^short = "Timing category for medication administration"

Invariant: medadm-not-done-must-have-status-reason
Description: "If the medication administration was not done, a statusReason should be provided."
Severity: #error
Expression: "status != 'not-done' or statusReason.exists()"

Invariant: medadm-status-reason-only-when-not-done
Description: "statusReason should only be present when status is not-done."
Severity: #warning
Expression: "statusReason.exists().not() or status = 'not-done'"

Profile: ParacetamolOnFeverMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: paracetamol-on-fever-medication-administration-profile
Title: "Paracetamol on Fever MedicationAdministration Profile"
Description: "MedicationAdministration profile for paracetamol administered because of fever."

* ^url = "http://tecnomod-um.org/StructureDefinition/paracetamol-on-fever-paracetamol-on-fever-medication-administration-profile"
* insert RESQProfileMetadata

* medication.concept 1..1 MS
* medication.reference 0..0
* medication.concept = SCT#387517004 "Paracetamol (substance)"

* reason 1..* MS
* reason only CodeableReference(FeverObservationProfile)
* reason.concept 0..0
* reason.reference 1..1 MS

* extension[assessmentTiming] 1..1 MS
* extension[assessmentTiming].valueCodeableConcept from ParacetamolOnFeverTimingVS (required)

Profile: InsulinOnHyperglycemiaMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: insulin-on-hyperglycemia-medication-administration-profile
Title: "Insulin on Hyperglycemia MedicationAdministration Profile"
Description: "MedicationAdministration profile for insulin administered in response to hyperglycemia."

* ^url = "http://tecnomod-um.org/StructureDefinition/insulin-on-hyperglycemia-medication-administration-profile"
* insert RESQProfileMetadata

* medication.concept 1..1 MS
* medication.reference 0..0
* medication.concept = SCT#67866001 "Insulin (substance)"

* reason 1..* MS
* reason only CodeableReference(HighestHyperglycemiaValueObservationProfile or HyperglycemiaObservationProfile)
* reason.concept 0..0
* reason.reference 1..1 MS

* extension[assessmentTiming] 1..1 MS
* extension[assessmentTiming].valueCodeableConcept from InsulinOnHyperglycemiaTimingVS (required)

Profile: NimodipineMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: nimodipine-medication-administration-profile
Title: "Nimodipine MedicationAdministration Profile"
Description: "MedicationAdministration profile for nimodipine in the subarachnoid hemorrhage pathway."

* ^url = "http://tecnomod-um.org/StructureDefinition/nimodipine-medication-administration-profile"
* insert RESQProfileMetadata

* medication.concept 1..1 MS
* medication.reference 0..0
* medication.concept = SCT#387502003 "Nimodipine (substance)"

* reason 0..* MS
* reason only CodeableReference(Condition or Observation)
* partOf 0..* MS
* partOf only Reference(Procedure)

* extension[assessmentTiming] 0..1 MS
* extension[assessmentTiming].valueCodeableConcept from NimodipinetimingVS (required)

Profile: AnticoagulantReversalMedicationAdministrationProfile
Parent: StrokeMedicationAdministrationProfile
Id: anticoagulant-reversal-medication-administration-profile
Title: "Anticoagulant Reversal MedicationAdministration Profile"
Description: "MedicationAdministration profile for anticoagulant reversal treatment in the acute stroke pathway, including completed and not-done reversal administrations."

* ^url = "http://tecnomod-um.org/StructureDefinition/anticoagulant-reversal-medication-administration-profile"
* insert RESQProfileMetadata

* obeys anticoagulant-reversal-not-done-must-have-status-reason
* obeys anticoagulant-reversal-status-reason-only-when-not-done

* medication 1..1 MS
* medication from AnticoagulantReversalVS (extensible)
* medication ^short = "Anticoagulant reversal medication or substance"

* status 1..1 MS
* status ^short = "Completed if reversal was administered; not-done if reversal was indicated/considered but not administered"

* occurence[x] 1..1 MS
* occurence[x] only dateTime or Period
* occurence[x] ^short = "Date/time or interval when reversal was administered or considered not done"

* reason 0..* MS
* reason only CodeableReference(Condition)
* reason ^short = "Clinical reason for anticoagulant reversal, such as hemorrhagic stroke, bleeding, anticoagulant use or coagulation-related observation"

* statusReason 0..* MS
* statusReason from NotMedicationReasonVS (extensible)
* statusReason ^short = "Reason anticoagulant reversal was not administered"

Invariant: anticoagulant-reversal-not-done-must-have-status-reason
Description: "If anticoagulant reversal was not done, a statusReason must be provided."
Severity: #error
Expression: "status != 'not-done' or statusReason.exists()"

Invariant: anticoagulant-reversal-status-reason-only-when-not-done
Description: "statusReason should only be present when anticoagulant reversal was not done."
Severity: #warning
Expression: "statusReason.exists().not() or status = 'not-done'"