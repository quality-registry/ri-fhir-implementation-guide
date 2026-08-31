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
