# Terminology

The IG exposes registry enumerations as computable FHIR terminology. Local CodeSystems preserve the values generated from `enum_models.py`; ValueSets provide the bindings used by profiles and extensions.

## Main Terminology Groups

| Group | Examples |
| --- | --- |
| Stroke pathway and admission | [AdmissionPathway ValueSet](ValueSet-admission-pathway-vs.html), [FirstContactPlace ValueSet](ValueSet-first-contact-place-vs.html), [DischargeDestination ValueSet](ValueSet-discharge-destination-vs.html) |
| Diagnosis and etiology | [StrokeType ValueSet](ValueSet-stroke-type-vs.html), [StrokeEtiology ValueSet](ValueSet-stroke-etiology-vs.html), [BleedingReason ValueSet](ValueSet-bleeding-reason-vs.html) |
| Observations and scores | [FunctionalScore ValueSet](ValueSet-functional-score-vs.html), [MRsScore ValueSet](ValueSet-mrs-score-vs.html), [GlasgowComaScale ValueSet](ValueSet-glasgow-coma-scale-vs.html), [TimingMetricCodes ValueSet](ValueSet-timing-metric-codes-vs.html) |
| Procedures | [PerforationProcedures ValueSet](ValueSet-perforation-procedures-vs.html), [VteProcedures ValueSet](ValueSet-vte-procedures-vs.html), [ProcedureNotDoneReason ValueSet](ValueSet-procedure-not-done-reason-vs.html) |
| Medication | [Medications ValueSet](ValueSet-medications-vs.html), [DischargeMedication ValueSet](ValueSet-discharge-medication-vs.html), [NotMedicationReason ValueSet](ValueSet-not-medication-reason-vs.html), [AdherenceCodes ValueSet](ValueSet-adherence-codes-vs.html) |
| Anatomy and measurements | [BodySites ValueSet](ValueSet-body-sites-vs.html), [Laterality ValueSet](ValueSet-laterality-vs.html), [UnitofMeasurement ValueSet](ValueSet-unitof-measurement-vs.html) |

## Binding Approach

Required bindings are used where the registry transformation expects a controlled and closed set of codes for correct interpretation. Extensible bindings are used where the registry list is preferred but interoperable implementations may need additional external codes.

External standards are reused when they fit the data element:

- SNOMED CT for clinical disorders, findings, procedures and substances.
- LOINC for observation concepts where applicable.
- UCUM for units such as minutes, millimeters of mercury and mmol/L.
- HL7 terminology CodeSystems for base FHIR status and category concepts.

See [Artifacts](artifacts.html) for the full generated list of CodeSystems and ValueSets.
