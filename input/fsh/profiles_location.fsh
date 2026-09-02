// -----------------------------------------------------------------------------
// Location profiles
// -----------------------------------------------------------------------------

Profile: RESQLocationProfile
Parent: Location
Id: resq-location-profile
Title: "RESQ Location Profile"
Description: "Generic coded location profile used by registry builders when the important information is the type of location or service rather than a fully described physical site."
* ^url = "http://qualityregistry.org/StructureDefinition/resq-location-profile"
* insert RESQProfileMetadata
* insert RESQSubmittedProfile
* ^purpose = "Provides a coded location/service container for stroke pathway data elements that are exchanged as Location resources."
* type 1..* MS
* type from LocationsVS (extensible)
* type ^short = "Registry location or service type"

Profile: HospitalizedLocationProfile
Parent: Location
Id: hospitalized-location-profile
Title: "Hospitalized Location Profile"
Description: "Hospitalized location profile aligned with the admission department and initial care intensity captured by the RES-Q source model."
* ^url = "http://qualityregistry.org/StructureDefinition/hospitalized-location-profile"
* insert RESQProfileMetadata
* insert RESQSubmittedProfile
* ^purpose = "Represents the inpatient department or unit type where the patient was hospitalized, including initial care intensity."
* type 1..* MS
* type from AdmissionDepartmentVS (extensible)
* type ^short = "Admission department or hospitalized location type"
* extension contains InitialCareIntensityExt named initialCareIntensity 1..1 MS
* extension[initialCareIntensity] ^short = "Initial intensity of hospitalized care"
