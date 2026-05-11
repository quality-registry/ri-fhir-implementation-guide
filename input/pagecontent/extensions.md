# Extensions

Extensions carry registry-specific semantics that do not fit cleanly into a standard FHIR R5 element or that are already emitted by the source builders.

| Extension | Used on | Purpose |
| --- | --- | --- |
| [Gender represented with SNOMED CT](StructureDefinition-gender-snomed-ext.html) | `Patient` | Represents sex/gender as a SNOMED CT CodeableConcept. |
| [First hospital for the stroke episode](StructureDefinition-first-hospital-ext.html) | `Encounter` | Indicates whether the encounter corresponds to the first hospital attended. |
| [EMS prenotification](StructureDefinition-ems-prenotification-ext.html) | `Encounter` | Records whether EMS prenotified the receiving hospital. |
| [Required post-acute care](StructureDefinition-required-post-acute-care-ext.html) | `Encounter`, `Observation`, `MedicationAdministration` | Marks post-acute-care relevance or requirement. |
| [Post-acute care required](StructureDefinition-post-acute-care-required-ext.html) | `Procedure` | Procedure-specific post-acute-care flag preserved from the source builders. |
| [Discharge department or service](StructureDefinition-discharge-department-service-ext.html) | `Encounter` | Captures discharge department/service or facility type. |
| [Initial care intensity](StructureDefinition-initial-care-intensity-ext.html) | `Location` | Captures ICU/stroke unit, monitored bed or standard bed context. |
| [Observation timing context](StructureDefinition-observation-timing-context-ext.html) | `Observation` | Adds timing context such as admission, discharge, prestroke or follow-up. |
| [Procedure timing context](StructureDefinition-procedure-timing-context-ext.html) | `Procedure` | Adds acute/post-acute or screening-window context. |
| [Assessment or medication timing](StructureDefinition-assessment-timing-ext.html) | `MedicationAdministration` | Records timing categories for medication-related assessments. |
| [Ischemic stroke etiology](StructureDefinition-ischemic-stroke-etiology-ext.html) | `Condition` | Captures known ischemic stroke etiology. |
| [Ischemic stroke etiology known/unknown coded state](StructureDefinition-ischemic-stroke-etiology-known-ext.html) | `Condition` | Captures unknown or undetermined etiology state. |
| [Hemorrhagic stroke bleeding reason](StructureDefinition-hemorrhagic-stroke-bleeding-reason-ext.html) | `Condition` | Captures known bleeding reason. |
| [Hemorrhagic stroke bleeding reason found coded state](StructureDefinition-hemorrhagic-stroke-bleeding-reason-found-ext.html) | `Condition` | Captures unknown or undetermined bleeding reason state. |
| [Wake-up stroke](StructureDefinition-wakeup-stroke-ext.html) | `Condition` | Indicates stroke first noticed after waking. |
