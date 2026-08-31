Profile: TenecteplaseBrandMedicationProfile
Parent: Medication
Id: tenecteplase-brand-medication-profile
Title: "Tenecteplase Brand Medication Profile"
Description: "Medication profile for tenecteplase with a specific brand name, used in the RES-Q registry to capture the use of tenecteplase in stroke treatment."
* ^url = "http://qualityregistry.org/StructureDefinition/tenecteplase-brand-medication-profile"
* insert RESQProfileMetadata
* ^purpose = "Represents tenecteplase medications with specific brand names to capture detailed treatment information for quality reporting and analysis."
* code 1..1 MS
* code from TenecteplaseBrandVS (extensible)
* code ^short = "Tenecteplase medication with specific brand name"
* ingredient 0..* MS
* ingredient.item 1..1 MS
* ingredient.item.concept = SCT#127967007 "Product containing tenecteplase (medicinal product)"
* ingredient.isActive = true
