// -----------------------------------------------------------------------------
// Patient profiles
// -----------------------------------------------------------------------------

Profile: RESQPatientProfile
Parent: Patient
Id: resq-patient-profile
Title: "RESQ Patient Profile"
Description: "Patient profile for RES-Q stroke registry submissions. The registry patient is intentionally pseudonymized: the profile requires a stable registry identifier and represents sex/gender using a SNOMED CT coded extension because the source ETL does not populate Patient.gender. Age is represented as an Observation in the registry model rather than as a Patient extension."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-patient-profile"
* insert RESQProfileMetadata
* ^purpose = "Provides a minimal, privacy-preserving patient anchor for all RES-Q stroke resources while retaining a coded sex/gender data element required for registry analytics."
* identifier 1..* MS
* identifier ^short = "Stable registry patient identifier"
* identifier ^definition = "Identifier used to link all resources belonging to the same registry subject. Implementers SHOULD avoid directly identifying national or local identifiers unless they are permitted for the exchange context."
* extension contains GenderSnomedExt named genderSnomed 0..1 MS
* extension[genderSnomed] ^short = "SNOMED CT sex/gender concept"
* gender 0..0
* gender ^short = "Not used by this registry profile"
* gender ^definition = "The source model records sex/gender as a coded SNOMED CT concept. Patient.gender is prohibited to prevent divergent representations."
