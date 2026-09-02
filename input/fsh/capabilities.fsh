// -----------------------------------------------------------------------------
// Capability statements for the RES-Q registry actors
//
// Generated shape: one statement per actor. The read/write split that a single
// CapabilityStatement cannot express -- Observation is both submitted and
// derived -- becomes expressible here because each actor gets its own document,
// and therefore its own supportedProfile list.
//
// The submission statement omits timing-metric-observation-profile (computed by
// the registry) and patient-reported-outcome-questionnaires (authored by it).
// -----------------------------------------------------------------------------

RuleSet: RESQCapabilityMetadata
* status = #active
* experimental = false
* version = "1.0.0"
* date = "2026-09-01"
* publisher = "Tecnomod / Universidad de Murcia"
* jurisdiction = urn:iso:std:iso:3166#ES "Spain"
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json
* format[+] = #xml


Instance: RESQRegistrySubmissionCapabilities
InstanceOf: CapabilityStatement
Usage: #definition
Title: "RES-Q Registry Submission Capabilities"
Description: "What the RES-Q registry accepts and stores when a Data Source submits a stroke episode."
* insert RESQCapabilityMetadata
* id = "resq-registry-submission-capabilities"
* url = "http://qualityregistry.org/CapabilityStatement/resq-registry-submission-capabilities"
* name = "RESQRegistrySubmissionCapabilities"
* title = "RES-Q Registry Submission Capabilities"
* description = "What the RES-Q registry accepts and stores when a Data Source submits a stroke episode."
* implementationGuide = "http://qualityregistry.org/ImplementationGuide/RESQFHIRIG"
* rest.mode = #server
* rest.documentation = """
Write side of the registry. A Data Source submits one transaction bundle per stroke episode.

Every profile listed under `supportedProfile` here is accepted and persisted. Profiles absent
from this list are not accepted, and are discarded if submitted. Two are absent on purpose:
`timing-metric-observation-profile`, which the registry computes, and
`patient-reported-outcome-questionnaires`, which the registry authors -- so the `Questionnaire`
resource type does not appear here at all. This list is the authoritative statement of what the
registry accepts.
"""
* rest.interaction[+].code = #transaction
* rest.interaction[+].code = #batch

* rest.resource[+].type = #BodyStructure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-body-structure-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Composition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-stroke-discharge-composition"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/post-stroke-complication-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-diagnosis-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-risk-factor-condition-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-encounter-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hospitalized-location-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-location-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tenecteplase-brand-medication-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationAdministration
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/anticoagulant-reversal-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/insulin-on-hyperglycemia-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/nimodipine-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/paracetamol-on-fever-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-medication-administration-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/discharge-medication-request-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/prior-medication-statement-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/self-reported-medication-notes"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/analitics-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/appointment-management-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/fever-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/functional-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glucose-ge10-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-systolic-blood-pressure-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hyperglycemia-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/no-anticoagulant-discharge-reason-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-ventilated-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/specific-finding-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/three-month-contact-mode-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/vital-sign-observation-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-registry-organization-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-patient-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-practitioner-role-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-mechanical-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-swallow-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-treatment-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-vte-procedure-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaire-responses"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

Instance: RESQRegistryQueryCapabilities
InstanceOf: CapabilityStatement
Usage: #definition
Title: "RES-Q Registry Query Capabilities"
Description: "What the RES-Q registry serves to consuming systems, including the resources it derives."
* insert RESQCapabilityMetadata
* id = "resq-registry-query-capabilities"
* url = "http://qualityregistry.org/CapabilityStatement/resq-registry-query-capabilities"
* name = "RESQRegistryQueryCapabilities"
* title = "RES-Q Registry Query Capabilities"
* description = "What the RES-Q registry serves to consuming systems, including the resources it derives."
* implementationGuide = "http://qualityregistry.org/ImplementationGuide/RESQFHIRIG"
* rest.mode = #server
* rest.documentation = """
Read side of the registry. Its profile list is a superset of the submission statement's, because
it also offers what the registry derives rather than receives.
"""
* rest.interaction[+].code = #search-system

* rest.resource[+].type = #BodyStructure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-body-structure-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference

* rest.resource[+].type = #Composition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-stroke-discharge-composition"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Composition-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/post-stroke-complication-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-diagnosis-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-risk-factor-condition-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DiagnosticReport-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-encounter-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Encounter-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hospitalized-location-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-location-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Location-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Location-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tenecteplase-brand-medication-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Medication-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #MedicationAdministration
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/anticoagulant-reversal-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/insulin-on-hyperglycemia-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/nimodipine-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/paracetamol-on-fever-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-medication-administration-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/discharge-medication-request-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/prior-medication-statement-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/self-reported-medication-notes"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/analitics-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/appointment-management-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/fever-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/functional-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glucose-ge10-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-systolic-blood-pressure-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hyperglycemia-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/no-anticoagulant-discharge-reason-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-ventilated-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/specific-finding-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/three-month-contact-mode-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/timing-metric-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/vital-sign-observation-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Observation-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-registry-organization-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-identifier"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-patient-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-practitioner-role-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-date"
* rest.resource[=].searchParam[=].type = #date

* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-mechanical-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-swallow-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-treatment-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-vte-procedure-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Procedure-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #Questionnaire
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaires"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CanonicalResource-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CanonicalResource-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CanonicalResource-status"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaire-responses"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "encounter"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-encounter"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-status"
* rest.resource[=].searchParam[=].type = #token

Instance: RESQDataSourceCapabilities
InstanceOf: CapabilityStatement
Usage: #definition
Title: "RES-Q Data Source Capabilities"
Description: "What a system submitting stroke episode data to the RES-Q registry must be able to produce."
* insert RESQCapabilityMetadata
* id = "resq-data-source-capabilities"
* url = "http://qualityregistry.org/CapabilityStatement/resq-data-source-capabilities"
* name = "RESQDataSourceCapabilities"
* title = "RES-Q Data Source Capabilities"
* description = "What a system submitting stroke episode data to the RES-Q registry must be able to produce."
* implementationGuide = "http://qualityregistry.org/ImplementationGuide/RESQFHIRIG"
* rest.mode = #client
* rest.documentation = """
A Data Source must be able to produce every profile listed here. It never produces the
profiles the registry derives for itself.
"""
* rest.interaction[+].code = #transaction

* rest.resource[+].type = #BodyStructure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-body-structure-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Composition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-stroke-discharge-composition"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/post-stroke-complication-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-diagnosis-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-risk-factor-condition-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-encounter-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hospitalized-location-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-location-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tenecteplase-brand-medication-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationAdministration
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/anticoagulant-reversal-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/insulin-on-hyperglycemia-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/nimodipine-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/paracetamol-on-fever-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-medication-administration-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/discharge-medication-request-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/prior-medication-statement-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/self-reported-medication-notes"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/analitics-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/appointment-management-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/fever-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/functional-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glucose-ge10-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-systolic-blood-pressure-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hyperglycemia-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/no-anticoagulant-discharge-reason-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-ventilated-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/specific-finding-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/three-month-contact-mode-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/vital-sign-observation-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-registry-organization-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-patient-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-practitioner-role-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-mechanical-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-swallow-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-treatment-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-vte-procedure-profile"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaire-responses"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update

Instance: RESQDataConsumerCapabilities
InstanceOf: CapabilityStatement
Usage: #definition
Title: "RES-Q Data Consumer Capabilities"
Description: "What a system reading from the RES-Q registry must be able to handle."
* insert RESQCapabilityMetadata
* id = "resq-data-consumer-capabilities"
* url = "http://qualityregistry.org/CapabilityStatement/resq-data-consumer-capabilities"
* name = "RESQDataConsumerCapabilities"
* title = "RES-Q Data Consumer Capabilities"
* description = "What a system reading from the RES-Q registry must be able to handle."
* implementationGuide = "http://qualityregistry.org/ImplementationGuide/RESQFHIRIG"
* rest.mode = #client
* rest.documentation = """
A Data Consumer must correctly handle every profile the registry can return, derived profiles
included. Derived resources are indistinguishable on the wire from submitted ones.
"""

* rest.resource[+].type = #BodyStructure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-body-structure-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Composition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-stroke-discharge-composition"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/post-stroke-complication-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-diagnosis-condition-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-risk-factor-condition-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-encounter-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hospitalized-location-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-location-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tenecteplase-brand-medication-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #MedicationAdministration
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/anticoagulant-reversal-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/insulin-on-hyperglycemia-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/nimodipine-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/paracetamol-on-fever-medication-administration-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-medication-administration-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/discharge-medication-request-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/prior-medication-statement-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/self-reported-medication-notes"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/analitics-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/appointment-management-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/fever-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/functional-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glasgow-coma-score-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/glucose-ge10-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/highest-systolic-blood-pressure-value-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/hyperglycemia-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/no-anticoagulant-discharge-reason-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-ventilated-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/specific-finding-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/three-month-contact-mode-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/timing-metric-observation-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/vital-sign-observation-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-registry-organization-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-patient-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/resq-practitioner-role-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-imaging-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-mechanical-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-swallow-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-treatment-procedure-profile"
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/stroke-vte-procedure-profile"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #Questionnaire
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaires"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = "http://qualityregistry.org/StructureDefinition/patient-reported-outcome-questionnaire-responses"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
