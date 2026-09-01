// -----------------------------------------------------------------------------
// MedicationStatement profiles
// -----------------------------------------------------------------------------

Profile: PriorMedicationStatementProfile
Parent: MedicationStatement
Id: prior-medication-statement-profile
Title: "Prior MedicationStatement Profile"
Description: "MedicationStatement profile for medication taken before stroke onset, including adherence state when captured by the registry."
* ^url = "http://qualityregistry.org/StructureDefinition/prior-medication-statement-profile"
* insert RESQProfileMetadata
* ^purpose = "Represents relevant pre-stroke medications and adherence as patient-reported or recorded medication use."
* status 1..1 MS
* status = #recorded
* status ^short = "Recorded prior medication use"
* insert RESQPatientSubject
* insert RESQEncounterContext
* medication 1..1 MS
* medication from MedicationsVS (extensible)
* medication ^short = "Medication used before stroke onset"
* adherence 1..1 MS
* adherence ^short = "Medication adherence details"
* adherence.code 1..1 MS
* adherence.code from AdherenceCodesVS (required)

Profile: SelfReportedMedicationNotes
Parent: MedicationStatement
Id: self-reported-medication-notes
Title: "Self-Reported Medication Notes"
Description: "MedicationStatement profile for medication a patient reports taking, as captured by the RES-Q questionnaire service alongside the patient-reported outcome questionnaires. The medication is carried as free text only, because the patient names the drug rather than selecting a coded product. Records the dose, the times of day the medication is taken, and the date range over which it was taken."
* ^url = "http://qualityregistry.org/StructureDefinition/self-reported-medication-notes"
* insert RESQProfileMetadata
* ^purpose = "Captures patient-reported medication use with enough dosing and timing detail to be interpretable, without asserting a coded medication the patient never selected."
* obeys smn-effective-end-after-start

* identifier 1..* MS
* identifier ^short = "Registry identifier of the medication statement"

* status 1..1 MS
* status = #recorded
* status ^short = "Recorded self-reported medication use"

* insert RESQPatientSubject

* encounter 0..1 MS
* encounter only Reference(StrokeEncounterProfile)
* encounter ^short = "Optional stroke encounter context"
* encounter ^definition = "Optional by design. Self-reported medication notes are collected with the patient-reported questionnaires, outside a hospital encounter, and the registry source model records no encounter for them."

// Medication is free text only. The patient names the drug; no coded product is
// selected, so a Coding here would assert a precision the data does not have.
* medication 1..1 MS
* medication.concept 1..1 MS
* medication.concept.text 1..1 MS
* medication.concept.text ^short = "Medication as the patient named it"
* medication.concept.coding 0..0
* medication.concept.coding ^definition = "Prohibited. This profile carries patient-reported medication as text only; use PriorMedicationStatementProfile when a coded medication is available."
* medication.reference 0..0

// Date range over which the medication was taken.
* effective[x] 1..1 MS
* effective[x] only Period
* effectivePeriod.start 1..1 MS
* effectivePeriod.start ^short = "First date the medication was taken"
* effectivePeriod.end 0..1 MS
* effectivePeriod.end ^short = "Last date the medication was taken; absent means still being taken"

* dateAsserted 1..1 MS
* dateAsserted ^short = "When the patient reported this medication"

* informationSource 0..1 MS
* informationSource only Reference(RESQPatientProfile)
* informationSource ^definition = "When populated, the patient who reported the medication. The registry source model does not currently record it, so absence does not mean the statement was not self-reported."

// Dosage: how much, how often, and at which times of day.
* dosage 1..* MS
* dosage ^short = "Dose and timing as reported by the patient"
* dosage.asNeeded 1..1 MS
* dosage.asNeeded ^short = "True when the medication is taken only as needed"
* dosage.timing 0..1 MS
* dosage.timing.repeat 1..1 MS
* dosage.timing.repeat.frequency 1..1 MS
* dosage.timing.repeat.frequency ^short = "Number of times taken per period"
* dosage.timing.repeat.period 1..1 MS
* dosage.timing.repeat.periodUnit 1..1 MS
* dosage.timing.repeat.periodUnit = #d
* dosage.timing.repeat.periodUnit ^definition = "Fixed to days. The registry source model offers no other period unit."
* dosage.timing.repeat.when 1..* MS
* dosage.timing.repeat.when from MedicationDosageWhenVS (required)
* dosage.timing.repeat.when ^short = "Times of day the medication is taken"
* dosage.doseAndRate 0..1 MS
* dosage.doseAndRate.dose[x] 1..1 MS
* dosage.doseAndRate.dose[x] only Quantity
* dosage.doseAndRate.doseQuantity from DoseFormUnitVS (required)
* dosage.doseAndRate.doseQuantity.value 1..1 MS
* dosage.doseAndRate.doseQuantity.system 1..1 MS
* dosage.doseAndRate.doseQuantity.code 1..1 MS
* dosage.doseAndRate.doseQuantity ^short = "Amount taken at each of those times"

* note 0..1 MS
* note ^short = "Free-text remark the patient added"

* adherence 0..0

Invariant: smn-effective-end-after-start
Description: "If the medication end date is present it SHALL NOT precede the start date."
Severity: #error
Expression: "effective.ofType(Period).end.empty() or effective.ofType(Period).end >= effective.ofType(Period).start"
