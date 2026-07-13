// =======================================================
// RESQ Stroke Hospital Discharge Composition Profile
// FHIR R5
// =======================================================

Alias: ListEmptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason

// -------------------------------------------------------
// ValueSet: Document type
// -------------------------------------------------------




// -------------------------------------------------------
// ValueSet: Section codes
// -------------------------------------------------------



// -------------------------------------------------------
// Profile: RESQ Stroke Hospital Discharge Composition
// -------------------------------------------------------

Profile: RESQStrokeDischargeComposition
Parent: Composition
Id: resq-stroke-discharge-composition
Title: "RESQ Stroke Hospital Discharge Composition"
Description: "FHIR R5 Composition profile for the RESQ Stroke Hospital Discharge Summary document."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-stroke-discharge-composition"
* ^name = "RESQStrokeDischargeComposition"
* ^status = #active
* ^version = "1.0.0"
* ^experimental = false
* ^publisher = "Tecnomod"
* ^jurisdiction = urn:iso:std:iso:3166#ES "Spain"
* ^fhirVersion = #5.0.0

// Document header
* status 1..1 MS
* status = #final

* type 1..1 MS
* type from RESQStrokeDischargeDocumentTypeVS (required)
* type = LOINC#18842-5 "Discharge summary"

* identifier 1..1 MS
* identifier.system 1..1 MS
* identifier.system = "https://stroke.qualityregistry.org/"
* identifier.value 1..1 MS

* subject 1..1 MS
* subject only Reference(Patient)

* encounter 0..1 MS
* encounter only Reference(Encounter)

* date 1..1 MS

* author 1..* MS
* author only Reference(Organization or Practitioner or PractitionerRole or Device)

* custodian 0..1 MS
* custodian only Reference(Organization)

* title 1..1 MS
* title = "Stroke Hospital Discharge Summary"

* text 1..1 MS

// Section base rules
* section 1..* MS
* section.code 1..1 MS
* section.code from RESQStrokeDischargeSectionCodeVS (required)
* section.title 1..1 MS
* section.text 1..1 MS
* section.entry MS
* section.emptyReason from http://hl7.org/fhir/ValueSet/list-empty-reason (required)


// -------------------------------------------------------
// Section slicing by section code
// -------------------------------------------------------

* section ^slicing.discriminator[0].type = #pattern
* section ^slicing.discriminator[0].path = "code"
* section ^slicing.rules = #open
* section ^slicing.ordered = false

* section contains
    admissionEvaluation 0..1 MS and
    patientHistory 0..1 MS and
    problemList 0..1 MS and
    hospitalCourse 1..1 MS and
    diagnosticSummary 0..1 MS and
    significantProcedures 0..1 MS and
    pharmacotherapy 0..1 MS and
    significantResults 0..1 MS and
    vitalSigns 0..1 MS and
    functionalStatus 0..1 MS and
    dischargeDetails 0..1 MS and
    dischargeMedications 0..1 MS and
    planOfCare 0..1 MS


// -------------------------------------------------------
// Admission Evaluation
// -------------------------------------------------------

* section[admissionEvaluation].title = "Admission Evaluation"
* section[admissionEvaluation].code = LOINC#67851-6 "Admission evaluation note"
* section[admissionEvaluation].entry only Reference(Condition or Observation or Location)


// -------------------------------------------------------
// Relevant Patient History
// -------------------------------------------------------

* section[patientHistory].title = "Relevant Patient History"
* section[patientHistory].code = LOINC#11329-0 "History of general health Narrative"
* section[patientHistory].entry only Reference(MedicationStatement)


// -------------------------------------------------------
// Relevant Problems and Risk Factors
// -------------------------------------------------------

* section[problemList].title = "Relevant Problems and Risk Factors"
* section[problemList].code = LOINC#11450-4 "Problem list - Reported"
* section[problemList].entry only Reference(Condition)


// -------------------------------------------------------
// Hospital Course
// Required section
// -------------------------------------------------------

* section[hospitalCourse].title = "Hospital Course"
* section[hospitalCourse].code = LOINC#8648-8 "Hospital course note"
* section[hospitalCourse].entry only Reference(Condition or Observation or Procedure or MedicationAdministration or DiagnosticReport)


// -------------------------------------------------------
// Diagnostic Summary
// -------------------------------------------------------

* section[diagnosticSummary].title = "Diagnostic Summary"
* section[diagnosticSummary].code = LOINC#11535-2 "Hospital discharge diagnosis Narrative"
* section[diagnosticSummary].entry only Reference(Condition or Observation)


// -------------------------------------------------------
// Significant Procedures
// -------------------------------------------------------

* section[significantProcedures].title = "Significant Procedures"
* section[significantProcedures].code = LOINC#10185-7 "Hospital discharge procedures"
* section[significantProcedures].entry only Reference(Procedure)


// -------------------------------------------------------
// Pharmacotherapy During Hospitalisation
// -------------------------------------------------------

* section[pharmacotherapy].title = "Pharmacotherapy During Hospitalisation"
* section[pharmacotherapy].code = LOINC#87232-5 "Medication administration brief"
* section[pharmacotherapy].entry only Reference(MedicationAdministration or MedicationStatement)


// -------------------------------------------------------
// Significant Results
// -------------------------------------------------------

* section[significantResults].title = "Significant Results"
* section[significantResults].code = LOINC#30954-2 "Relevant diagnostic tests/laboratory data Narrative"
* section[significantResults].entry only Reference(Observation or DiagnosticReport)


// -------------------------------------------------------
// Vital Signs at Discharge
// -------------------------------------------------------

* section[vitalSigns].title = "Vital Signs at Discharge"
* section[vitalSigns].code = LOINC#8716-3 "Vital signs note"
* section[vitalSigns].entry only Reference(Observation)


// -------------------------------------------------------
// Functional Status at Discharge
// -------------------------------------------------------

* section[functionalStatus].title = "Functional Status at Discharge"
* section[functionalStatus].code = LOINC#47420-5 "Functional status assessment note"
* section[functionalStatus].entry only Reference(Observation or Condition or QuestionnaireResponse)


// -------------------------------------------------------
// Discharge Details
// -------------------------------------------------------

* section[dischargeDetails].title = "Discharge Details"
* section[dischargeDetails].code = LOINC#8650-4 "Hospital discharge disposition note"
* section[dischargeDetails].entry only Reference(Encounter)


// -------------------------------------------------------
// Discharge Medications
// -------------------------------------------------------

* section[dischargeMedications].title = "Discharge Medications"
* section[dischargeMedications].code = LOINC#75311-1 "Discharge medications Narrative"
* section[dischargeMedications].entry only Reference(MedicationRequest or MedicationStatement)


// -------------------------------------------------------
// Plan of Care and Follow-up
// -------------------------------------------------------

* section[planOfCare].title = "Plan of Care and Follow-up"
* section[planOfCare].code = LOINC#18776-5 "Plan of care note"
* section[planOfCare].entry only Reference(Appointment or CarePlan or ServiceRequest or Procedure or Observation)