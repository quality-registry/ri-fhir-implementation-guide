# RESQ Stroke Registry Implementation Guide

This FHIR Shorthand package defines the RESQ stroke registry profiles, extensions, CodeSystems and ValueSets derived from the Python resource builders and enum model used in the transformation pipeline.

## Scope

The IG covers the complete transaction bundle produced by `transform_to_fhir`: Organization, Patient, Encounter, Location, Condition, Observation, Procedure, DiagnosticReport, BodyStructure, MedicationStatement, MedicationRequest, MedicationAdministration, PractitionerRole, Appointment and Communication.

## Modeling conventions

- `Patient` keeps only the identifier and a SNOMED-coded gender/sex extension. Age is modeled as an `Observation` because that is how the pipeline constructs it.
- The index admission is modeled as `StrokeEncounterProfile` with admission source, discharge disposition, first-hospital flag, post-acute-care flag and EMS prenotification.
- Clinical state is split into `Condition` profiles for diagnosis/risk factors/complications and `Observation` profiles for measurements, scores, imaging findings and timing indicators.
- Procedures are specialized for imaging, carotid imaging, carotid endarterectomy, reperfusion, swallowing screening, VTE prophylaxis and broader stroke treatments.
- MedicationStatement captures prior medication adherence; MedicationRequest captures discharge medication orders; MedicationAdministration captures acute treatment administration.
- Local codes from `enum_models.py` are generated as CodeSystems under `http://tecnomod-um.org/CodeSystem/...`, with one ValueSet per enum class.

## Known normalization notes

The Python builders include both `required-post-acute-care-ext` and `post-acute-care-required-ext`. Both are preserved as separate extension URLs because both appear in the implementation. The MedicationAdministration builders also contain a typo URL `http://tecnomod-um-org/StructureDefinition/assessment-timing-ext`; the IG normalizes this to `http://tecnomod-um.org/StructureDefinition/assessment-timing-ext`.

## Build

Install SUSHI and run:

```bash
sushi .
```

Then run the HL7 IG Publisher if you want the full HTML guide.
