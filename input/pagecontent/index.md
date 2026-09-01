# RESQ Stroke Registry Implementation Guide

This guide describes how RES-Q stroke registry data is represented in HL7 FHIR R5. It is designed for implementers who need to create, validate, inspect or consume the FHIR resources produced from the registry transformation pipeline.

<div class="resq-hero">
  <div>
    <p class="resq-kicker">FHIR R5 implementation guide</p>
    <h2>Stroke registry data, organized as navigable FHIR resources</h2>
    <p>The model turns one stroke episode into a connected resource graph: a patient and encounter anchor the record, while diagnoses, observations, procedures, medications, reports and follow-up resources describe the clinical pathway.</p>
  </div>
  <div class="resq-stat-grid">
    <a class="resq-stat" href="profiles.html"><strong>48</strong><span>Profiles</span></a>
    <a class="resq-stat" href="extensions.html"><strong>15</strong><span>Extensions</span></a>
    <a class="resq-stat" href="terminology.html"><strong>127</strong><span>Terminology artifacts</span></a>
    <a class="resq-stat" href="resource-map.html"><strong>17</strong><span>FHIR resource types</span></a>
  </div>
</div>

## Start here

<div class="resq-card-grid">
  <a class="resq-card" href="resource-map.html">
    <strong>Resource map</strong>
    <span>See every FHIR resource type used in the IG and how the resources connect across a stroke episode.</span>
  </a>
  <a class="resq-card" href="modeling.html">
    <strong>Modeling decisions</strong>
    <span>Understand why the registry is split across Patient, Encounter, Condition, Observation, Procedure and medication resources.</span>
  </a>
  <a class="resq-card" href="profiles.html">
    <strong>Profiles by resource</strong>
    <span>Jump directly to the StructureDefinition pages for each profile.</span>
  </a>
  <a class="resq-card" href="terminology.html">
    <strong>Terminology</strong>
    <span>Review the local CodeSystems and ValueSets generated from the registry enumeration model.</span>
  </a>
</div>

## Scope

The IG covers the complete transaction bundle produced by `transform_to_fhir`: `Organization`, `Patient`, `Encounter`, `Location`, `Condition`, `Observation`, `Procedure`, `DiagnosticReport`, `BodyStructure`, `MedicationStatement`, `MedicationRequest`, `MedicationAdministration`, `PractitionerRole`, `Appointment` and `Communication`.

## Resource graph

```mermaid
flowchart LR
  Org["Organization"] --> Enc["StrokeEncounter"]
  Pat["RESQPatient"] --> Enc
  Enc --> Dx["Diagnosis Condition"]
  Enc --> Risk["Risk Factors / Complications"]
  Enc --> Obs["Observations: scores, labs, findings, timing"]
  Enc --> Proc["Procedures: imaging, reperfusion, screening"]
  Proc --> Rep["DiagnosticReport"]
  Rep --> Obs
  Enc --> Med["MedicationStatement / Request / Administration"]
  Enc --> Fu["Appointment / Communication follow-up"]
  Body["BodyStructure"] --> Obs
```

## Modeling conventions

- `Patient` is intentionally minimal and privacy-preserving. It carries the registry identifier and a SNOMED-coded sex/gender extension; age is represented as an `Observation` because the source pipeline creates it as a measurable registry datum.
- `Encounter` is the clinical anchor for the index stroke episode. It carries admission source, discharge disposition, first-hospital flag, post-acute-care flag and EMS prenotification.
- `Condition` is used for durable clinical assertions: stroke diagnosis, risk factors and post-stroke complications.
- `Observation` is used for measurements, scales, laboratory/analytics values, imaging findings, process timings and follow-up indicators.
- `Procedure` is used for actions performed or considered in care delivery: imaging, reperfusion, swallowing screening, VTE prophylaxis, carotid endarterectomy and other stroke treatments.
- Medication resources are separated by meaning: prior medication use is `MedicationStatement`, discharge prescriptions are `MedicationRequest`, and administered acute treatment is `MedicationAdministration`.

## Known normalization notes

The Python builders include both `required-post-acute-care-ext` and `post-acute-care-required-ext`. Both are preserved as separate extension URLs because both appear in the implementation. The MedicationAdministration builders also contain a typo URL `http://tecnomod-um-org/StructureDefinition/assessment-timing-ext`; the IG normalizes this to `http://qualityregistry.org/StructureDefinition/assessment-timing-ext`.
