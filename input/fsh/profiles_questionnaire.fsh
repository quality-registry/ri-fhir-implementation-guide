// -----------------------------------------------------------------------------
// Questionnaire profiles
// -----------------------------------------------------------------------------

Profile: PatientReportedOutcomeQuestionnaires
Parent: Questionnaire
Id: patient-reported-outcome-questionnaires
Title: "Patient Reported Outcome Questionnaires"
Description: "Questionnaire profile for the patient-reported outcome instruments collected by the RES-Q stroke registry. The profile fixes the shape shared by all four instruments as the registry operates them: a fully identified and versioned definition, a coded instrument identifier, and a flat list of coded, required, non-repeating questions. Nesting and repeating questions are prohibited because the registry source model supports neither."
* ^url = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaires"
* insert RESQProfileMetadata
* ^purpose = "Ensures every patient-reported outcome instrument published for the registry is individually addressable, versioned and coded, so that a QuestionnaireResponse can be resolved to an unambiguous definition and its answers scored consistently."
* obeys prom-coding-item-has-answer-option
* url 1..1 MS
* url ^short = "Canonical URL of this instrument"
* identifier 1..* MS
* identifier ^short = "Registry identifiers for this instrument"
* identifier ^definition = "Carries the questionnaire service resource_id used to address the instrument over the REST API, and the legacy canonical URL the service published before this guide."
* version 1..1 MS
* version ^short = "Business version of the instrument"
* name 1..1 MS
* name ^short = "Machine-readable name"
* title 1..1 MS
* title ^short = "Human-readable instrument name"
* status 1..1 MS
* status ^short = "Publication status"
* experimental 1..1 MS
* date 1..1 MS
* date ^short = "Date the instrument definition last changed"
* publisher 1..1 MS
* code 1..* MS
* code from RESQQuestionnaireCodeVS (required)
* code ^short = "Coded identifier of the instrument"
* item 1..* MS
* item ^short = "The questions, in presentation order"
* item.linkId 1..1 MS
* item.linkId ^short = "Stable question identifier referenced by responses and skip logic"
* item.code 1..1 MS
* item.code ^short = "Coded meaning of the question"
* item.text 1..1 MS
* item.text ^short = "Question as presented to the respondent"
* item.type 1..1 MS
* item.required 1..1 MS
* item.repeats 1..1 MS
* item.repeats = false
* item.repeats ^short = "Questions never repeat in this registry"
* item.item 0..0
* item.item ^short = "Not used by this registry profile"
* item.item ^definition = "The registry source model has no parent-child relationship between questions, so every instrument is a flat list."

Invariant: prom-coding-item-has-answer-option
Description: "A coding question SHALL enumerate its permitted answers."
Severity: #error
Expression: "item.all(type != 'coding' or answerOption.exists())"
