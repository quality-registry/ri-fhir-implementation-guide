// -----------------------------------------------------------------------------
// MedicationRequest profiles
// -----------------------------------------------------------------------------

Profile: DischargeMedicationRequestProfile
Parent: MedicationRequest
Id: discharge-medication-request-profile
Title: "Discharge MedicationRequest Profile"
Description: "MedicationRequest profile for medications prescribed or recommended at discharge after the index stroke encounter."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/discharge-medication-request-profile"
* insert RESQProfileMetadata
* ^purpose = "Captures discharge medication orders needed for quality reporting and secondary prevention analysis."
* status 1..1 MS
* status = #active
* status ^short = "Active discharge medication request"
* intent 1..1 MS
* intent = #order
* intent ^short = "Medication order intent"
* category 1..* MS
* category = MedicationRequestAdminLocationCS#community
* category ^short = "Community/discharge medication category"
* insert RESQPatientSubject
* insert RESQEncounterContext
* medication 1..1 MS
* medication from MedicationsVS (extensible)
* medication ^short = "Medication requested at discharge"
