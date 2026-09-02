// -----------------------------------------------------------------------------
// Common profile metadata and reusable conformance rules
// -----------------------------------------------------------------------------

RuleSet: RESQProfileMetadata
* ^status = #active
* ^experimental = false
* ^publisher = "Tecnomod / Universidad de Murcia"
* ^jurisdiction = urn:iso:std:iso:3166#ES "Spain"
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

// -----------------------------------------------------------------------------
// Direction-of-exchange obligations
//
// Only two obligation codes are used:
//   SHALL:able-to-populate -- this actor produces instances of the profile
//   SHALL:handle           -- this actor must correctly process instances
//
// Direction reads straight off the table:
//   submitted -> Data Source populates; Registry handles AND populates
//   derived   -> no Data Source row;    Registry only populates
//
// Applied to the profile's root element, so they render in the obligation table
// on each profile page. Deliberately NOT applied to BaseStrokeObservation:
// element-level obligations are inherited through snapshot generation, which
// would push "submitted" obligations onto its derived timing-metric child.
//
// Actors are defined in actors.fsh. See exchange.html.
// -----------------------------------------------------------------------------

RuleSet: RESQSubmittedProfile
// A Data Source produces it; the registry accepts it, stores it and offers it on.
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQDataSource)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:able-to-populate"
* . ^extension[=].extension[+].url = "documentation"
* . ^extension[=].extension[=].valueMarkdown = "The Data Source produces instances of this profile and submits them, even where an individual stroke episode carries no data for it."
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQRegistry)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:handle"
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:able-to-populate"
* . ^extension[=].extension[+].url = "documentation"
* . ^extension[=].extension[=].valueMarkdown = "The registry accepts instances of this profile on submission, validates and stores them, and offers them back to consuming systems."
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQDataConsumer)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:handle"

RuleSet: RESQRegistryDerivedProfile
// The registry computes it. No Data Source row, and the registry has no
// SHALL:handle: nobody submits this profile and the registry does not accept it.
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQRegistry)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:able-to-populate"
* . ^extension[=].extension[+].url = "documentation"
* . ^extension[=].extension[=].valueMarkdown = "The registry derives instances of this profile and offers them whenever it holds the inputs the derivation needs. This profile is computed by the registry, not submitted to it: no Data Source produces it, and any instance arriving in a submission bundle is discarded rather than stored, so that it cannot compete with the registry's own derivation."
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQDataConsumer)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:handle"

RuleSet: RESQRegistryAuthoredProfile
// Authored and maintained inside RES-Q, not computed from other data. It can be
// exported but not added: no Data Source row, but the registry handles it.
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQRegistry)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:handle"
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:able-to-populate"
* . ^extension[=].extension[+].url = "documentation"
* . ^extension[=].extension[=].valueMarkdown = "This profile is authored and maintained by RES-Q. It can be exported to consuming systems but cannot be added by a Data Source: the registry does not accept instances of it on submission."
* . ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/obligation"
* . ^extension[=].extension[+].url = "actor"
* . ^extension[=].extension[=].valueCanonical = Canonical(RESQDataConsumer)
* . ^extension[=].extension[+].url = "code"
* . ^extension[=].extension[=].valueCode = #"SHALL:handle"
