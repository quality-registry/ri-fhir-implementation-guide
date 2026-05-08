// -----------------------------------------------------------------------------
// Organization profiles
// -----------------------------------------------------------------------------

Profile: StrokeRegistryOrganizationProfile
Parent: Organization
Id: stroke-registry-organization-profile
Title: "Stroke Registry Organization Profile"
Description: "Organization profile for hospitals or registry participants contributing RES-Q stroke data. The profile requires an active organization, a display name and a registry-scoped identifier."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-registry-organization-profile"
* insert RESQProfileMetadata
* ^purpose = "Identifies the care organization or hospital associated with registry encounters and submitted data."
* active 1..1 MS
* active = true
* active ^short = "Organization currently active in the registry context"
* name 1..1 MS
* name ^short = "Canonical hospital or registry organization name"
* identifier 1..* MS
* identifier ^short = "Organization identifiers"
* identifier ^slicing.discriminator[0].type = #value
* identifier ^slicing.discriminator[0].path = "system"
* identifier ^slicing.rules = #open
* identifier contains registry 1..1 MS
* identifier[registry] ^short = "RES-Q registry organization identifier"
* identifier[registry].system 1..1 MS
* identifier[registry].system = StrokeRegistryIdSystem (exactly)
* identifier[registry].value 1..1 MS
