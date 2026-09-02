// ----------------------------------------------------------------------------
// QuestionnaireResponse profiles
// ----------------------------------------------------------------------------

Profile: PatientReportedOutcomeQuestionnaireResponses
Parent: QuestionnaireResponse
Id: patient-reported-outcome-questionnaire-responses
Title: "Patient Reported Outcome Questionnaire Responses"
Description: "Patient-reported answers to one of the four RES-Q questionnaires (mRS, PHQ-9, SF-SIS, SF-NEADL). The profile mirrors the flat answer model of the RES-Q questionnaire service: every response item carries at most one answer, items are never nested, and an item the respondent skipped is flagged with an extension instead of being omitted. Responses are collected during patient intake and at three-month follow-up, so they are not tied to a hospital encounter."
* ^url = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaire-responses"
* insert RESQProfileMetadata
* insert RESQSubmittedProfile
* ^purpose = "Constrains patient-reported questionnaire answers to the shape the registry actually collects, so that responses can be validated against the four published Questionnaire definitions and consumed as evidence for the derived functional-outcome scores."
* insert RESQPatientSubject
* obeys resq-qr-item-answer-or-skipped
* obeys prom-qr-known-questionnaire
* questionnaire 1..1 MS
* questionnaire only Canonical(PatientReportedOutcomeQuestionnaires)
* questionnaire ^short = "Canonical URL of the RES-Q questionnaire answered"
* questionnaire ^definition = "Resolves to one of the four questionnaires published by this guide: MrsQuestionnaire, Phq9Questionnaire, SfSisQuestionnaire or SfNeadlQuestionnaire. The service addresses questionnaires by its own resource_id, which is carried on each Questionnaire as an identifier."
* status 1..1 MS
* status ^short = "Response lifecycle status"
* authored 1..1 MS
* authored ^short = "When the respondent completed the questionnaire"
* encounter 0..1 MS
* encounter only Reference(StrokeEncounterProfile)
* encounter ^short = "Index stroke encounter, when the response was collected in hospital"
* encounter ^definition = "Optional by design. Intake and three-month follow-up responses are collected outside a hospital encounter, and the registry source model records no encounter for a questionnaire response."
* source 0..1 MS
* source ^short = "Who provided the answers"
* source ^definition = "The registry source model records this as a coded role (patient, related person, practitioner or device) rather than a reference. A patient-reported response is represented here as a reference to the subject; the other three roles have no corresponding resource in the registry payload and are currently not exchanged."
* item 1..* MS
* item ^short = "One entry per answered or skipped question"
* item.linkId 1..1 MS
* item.linkId ^short = "linkId of the matching Questionnaire item"
* item.answer 0..1 MS
* item.answer ^short = "The single answer given, absent when the item was skipped"
* item.answer ^definition = "No RES-Q questionnaire item repeats, so an item yields at most one answer."
* item.item 0..0
* item.item ^short = "Not used by this registry profile"
* item.answer.item 0..0
* item.answer.item ^short = "Not used by this registry profile"
* item.extension contains QuestionnaireSkippedItemExt named skipped 0..1 MS
* item.extension[skipped] ^short = "Item deliberately skipped by the respondent"

Invariant: resq-qr-item-answer-or-skipped
Description: "A response item SHALL either carry an answer or be flagged as skipped."
Severity: #error
Expression: "item.all(answer.exists() or extension('http://qualityregistry.org/StructureDefinition/questionnaire-skipped-item-ext').exists())"

Invariant: prom-qr-known-questionnaire
Description: "The response SHALL answer one of the four patient-reported outcome questionnaires defined by this implementation guide. The canonical is matched exactly, so a version-suffixed canonical such as ...mrs-questionnaire|1.0.0 does not satisfy this constraint; the registry questionnaire service sends unversioned canonicals."
Severity: #error
Expression: "questionnaire in ('http://qualityregistry.org/Questionnaire/mrs-questionnaire' | 'http://qualityregistry.org/Questionnaire/phq9-questionnaire' | 'http://qualityregistry.org/Questionnaire/sf-sis-questionnaire' | 'http://qualityregistry.org/Questionnaire/sf-neadl-questionnaire')"
