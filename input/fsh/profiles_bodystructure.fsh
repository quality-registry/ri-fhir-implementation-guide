// -----------------------------------------------------------------------------
// BodyStructure profiles
// -----------------------------------------------------------------------------

Profile: RESQBodyStructureProfile
Parent: BodyStructure
Id: resq-body-structure-profile
Title: "RESQ BodyStructure Profile"
Description: "BodyStructure profile for anatomical structures relevant to stroke, such as occluded arteries, stenosis sites and laterality-specific findings."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/resq-body-structure-profile"
* insert RESQProfileMetadata
* ^purpose = "Allows observations and reports to reference a normalized anatomical site instead of repeating less structured body-site information."
* patient 1..1 MS
* patient only Reference(RESQPatientProfile)
* patient ^short = "Patient whose anatomical structure is described"
* includedStructure 1..* MS
* includedStructure ^short = "Anatomical structure relevant to the stroke episode"
* includedStructure.structure 1..1 MS
* includedStructure.structure from BodySitesVS (extensible)
* includedStructure.structure ^short = "Coded artery or anatomical site"
* includedStructure.laterality 0..1 MS
* includedStructure.laterality from LateralityVS (extensible)
* includedStructure.laterality ^short = "Left/right/bilateral laterality where applicable"
