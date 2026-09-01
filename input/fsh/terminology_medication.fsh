// -----------------------------------------------------------------------------
// Terminology for self-reported medication notes
//
// Hand-authored, deliberately kept out of terminology_generated.fsh so a
// regeneration from enum_models.py cannot clobber it.
//
// Concept codes are the values the RES-Q questionnaire service stores and sends
// (apps/questionnaire_app/models.py, DoseUnit and DosageWhen). They are kept
// verbatim, including the ones that are not UCUM, because they already exist in
// live payloads and in the MedicationDosage rows.
// -----------------------------------------------------------------------------

CodeSystem: DoseFormUnitCS
Id: dose-form-unit-cs
Title: "DoseFormUnit CodeSystem"
Description: "Units in which a patient-reported dose is counted. Mirrors the DoseUnit enum in the questionnaire service. Two of the four codes have no UCUM equivalent because they name a dose form rather than a measure; the UCUM equivalents of the others are ml -> mL and grams -> g."
* ^url = "http://qualityregistry.org/CodeSystem/dose-form-unit-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #tablet "Tablet"
* #capsule "Capsule"
* #ml "Millilitre"
* #grams "Gram"

ValueSet: DoseFormUnitVS
Id: dose-form-unit-vs
Title: "DoseFormUnit ValueSet"
Description: "Allowed dose units for a patient-reported medication dose."
* ^url = "http://qualityregistry.org/ValueSet/dose-form-unit-vs"
* ^status = #active
* ^experimental = false
* include codes from system DoseFormUnitCS

ValueSet: MedicationDosageWhenVS
Id: medication-dosage-when-vs
Title: "MedicationDosageWhen ValueSet"
Description: "Times of day at which a patient reports taking a medication. A required-binding subset of the FHIR EventTiming code system, restricted to the four periods the questionnaire service offers (DosageWhen enum: MORN, AFT, EVE, NIGHT)."
* ^url = "http://qualityregistry.org/ValueSet/medication-dosage-when-vs"
* ^status = #active
* ^experimental = false
* include EventTimingCS#MORN "Morning"
* include EventTimingCS#AFT "Afternoon"
* include EventTimingCS#EVE "Evening"
* include EventTimingCS#NIGHT "Night"
