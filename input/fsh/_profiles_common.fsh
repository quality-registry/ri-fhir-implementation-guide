// -----------------------------------------------------------------------------
// Common profile metadata and reusable conformance rules
// -----------------------------------------------------------------------------

RuleSet: RESQProfileMetadata
* ^status = #active
* ^experimental = false
* ^publisher = "Health Management Institute z.ú."
// * ^jurisdiction = urn:iso:std:iso:3166#EU "European Union"
* ^jurisdiction = urn:iso:std:iso:3166#CZ "Czechia"
* ^version = "1.0.0"

RuleSet: RESQPatientSubject
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* subject ^short = "RES-Q registry patient"
* subject ^definition = "Patient who experienced the index stroke episode represented in this registry dataset."

RuleSet: RESQEncounterContext
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* encounter ^short = "Index stroke encounter"
* encounter ^definition = "Encounter that anchors the clinical fact to the acute stroke episode and hospital pathway."

RuleSet: RESQObservationCore
* status 1..1 MS
* status = #final
* status ^short = "Final registry observation"
* code 1..1 MS
* code ^short = "Registry observation concept"
* insert RESQPatientSubject
* insert RESQEncounterContext

RuleSet: RESQProcedureCore
* status 1..1 MS
* status ^short = "Procedure status"
* code 1..1 MS
* code ^short = "Procedure concept"
* insert RESQPatientSubject
* insert RESQEncounterContext

RuleSet: RESQDiagnosticReportCore
* status 1..1 MS
* status = #final
* status ^short = "Final diagnostic report"
* code 1..1 MS
* code ^short = "Report type"
* insert RESQPatientSubject
* insert RESQEncounterContext
