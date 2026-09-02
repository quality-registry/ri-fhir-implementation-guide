// -----------------------------------------------------------------------------
// PractitionerRole profiles
// -----------------------------------------------------------------------------

Profile: RESQPractitionerRoleProfile
Parent: PractitionerRole
Id: resq-practitioner-role-profile
Title: "RESQ PractitionerRole Profile"
Description: "PractitionerRole profile for recording the type of clinician or professional performing swallowing screening and related pathway activities."
* ^url = "http://qualityregistry.org/StructureDefinition/resq-practitioner-role-profile"
* insert RESQProfileMetadata
* ^purpose = "Captures performer role categories when the source registry records a role rather than an individually identified practitioner."
* code 1..* MS
* code from ScreeningPerformerVS (extensible)
* code ^short = "Performer role category"
