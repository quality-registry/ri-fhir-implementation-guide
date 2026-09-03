// ----------------------------------------------------------------------------
// Terminology for the RES-Q patient-reported questionnaires
//
// The three CodeSystems below replace local systems that the RES-Q questionnaire
// service publishes under qualityregistry.org. The legacy URI is recorded in each
// Description because it still appears in Coding.system in live QuestionnaireResponse
// payloads and in the service's Code table; the service must be migrated onto the
// URLs defined here.
//
// Concept codes are kept exactly as the service emits them ("1".."5",
// "sfsis_q1_custom", "sfneadl_q3_custom") rather than being re-cased to this IG's
// usual kebab-case, because they are values in existing response data.
// ----------------------------------------------------------------------------

CodeSystem: SfSisAnswersCS
Id: sf-sis-answers-cs
Title: "SfSisAnswers CodeSystem"
Description: "Answer scale shared by every item of the short-form Stroke Impact Scale questionnaire. Replaces the legacy system https://qualityregistry.org/fhir/code-system/sf-sis-answers published by the RES-Q questionnaire service."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/sf-sis-answers-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #1 "Could not do it at all"
* #2 "Very difficult"
* #3 "Somewhat difficult"
* #4 "A little difficult"
* #5 "Not difficult at all"

CodeSystem: SupplementalQuestionsCS
Id: supplemental-questions-cs
Title: "SupplementalQuestions CodeSystem"
Description: "Local question codes for the two questionnaire items that have no suitable SNOMED CT concept. Replaces the legacy system https://qualityregistry.org/fhir/code-system/supplemental-questions published by the RES-Q questionnaire service."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/supplemental-questions-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #sfsis_q1_custom "In the past week, how would you rate the strength of your leg that was most affected by your stroke?"
* #sfneadl_q3_custom "In the past week, did you take hot drinks from one room to another?"

CodeSystem: RESQQuestionnairesCS
Id: resq-questionnaires-cs
Title: "RESQQuestionnaires CodeSystem"
Description: "Identifies the RES-Q questionnaire instruments that have no SNOMED CT or LOINC concept. Used both as Questionnaire.code and as Observation.code for the derived summary score. Replaces the legacy system https://qualityregistry.org/fhir/code-system/questionnaires published by the RES-Q questionnaire service."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/resq-questionnaires-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #sfsis "short-form Stroke Impact Scale"
* #sfneadl "short-form Nottingham Extended Activities of Daily Living"

// The three answer ValueSets below are published for validators and downstream
// tooling. They are intentionally not bound by any profile in this IG: the four
// Questionnaire instances enumerate answerOption inline to mirror what the service
// returns, and FHIR forbids answerOption and answerValueSet on the same item.

ValueSet: SfSisAnswersVS
Id: sf-sis-answers-vs
Title: "SfSisAnswers ValueSet"
Description: "Allowed answers for every item of the short-form Stroke Impact Scale questionnaire."
* ^url = "http://fhir.qualityregistry.org/ValueSet/sf-sis-answers-vs"
* ^status = #active
* ^experimental = false
* include codes from system SfSisAnswersCS

ValueSet: Phq9AnswersVS
Id: phq9-answers-vs
Title: "Phq9Answers ValueSet"
Description: "Allowed answers for every item of the PHQ-9 questionnaire, weighted 0 to 3."
* ^url = "http://fhir.qualityregistry.org/ValueSet/phq9-answers-vs"
* ^status = #active
* ^experimental = false
* include SCT#260353006 "Nothing at all"
* include SCT#5878004 "Low frequency"
* include SCT#255218000 "Mid-frequency"
* include SCT#27732004 "High frequency"

ValueSet: SfNeadlAnswersVS
Id: sf-neadl-answers-vs
Title: "SfNeadlAnswers ValueSet"
Description: "Allowed answers for every item of the short-form Nottingham Extended Activities of Daily Living questionnaire, weighted 1 to 4."
* ^url = "http://fhir.qualityregistry.org/ValueSet/sf-neadl-answers-vs"
* ^status = #active
* ^experimental = false
* include SCT#371151008 "Unable"
* include SCT#371154000 "Dependent"
* include SCT#371157007 "Able with difficulty"
* include SCT#371153006 "Independently able"

ValueSet: RESQQuestionnaireCodeVS
Id: resq-questionnaire-code-vs
Title: "RESQQuestionnaireCode ValueSet"
Description: "Codes identifying the four patient-reported questionnaires collected by the RES-Q registry, as used in Questionnaire.code."
* ^url = "http://fhir.qualityregistry.org/ValueSet/resq-questionnaire-code-vs"
* ^status = #active
* ^experimental = false
* include SCT#840352000 "Modified Rankin Scale"
* include SCT#715252007 "Depression screening using Patient Health Questionnaire Nine Item score (procedure)"
* include RESQQuestionnairesCS#sfsis "short-form Stroke Impact Scale"
* include RESQQuestionnairesCS#sfneadl "short-form Nottingham Extended Activities of Daily Living"
