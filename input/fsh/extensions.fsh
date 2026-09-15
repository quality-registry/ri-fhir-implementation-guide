// -----------------------------------------------------------------------------
// RESQ Stroke Registry Extensions
// -----------------------------------------------------------------------------

Extension: GenderSnomedExt
Id: gender-snomed-ext
Title: "Gender represented with SNOMED CT"
Description: "Sex/gender value as a SNOMED CT CodeableConcept, matching build_Patient()."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/gender-snomed-ext"
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from SexVS (required)

Extension: FirstHospitalExt
Id: first-hospital-ext
Title: "First hospital for the stroke episode"
Description: "Boolean flag indicating whether the Encounter corresponds to the first hospital attended for the index stroke episode."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/first-hospital-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only Reference
* valueReference 1..1 MS

Extension: EmsPrenotificationExt
Id: ems-prenotification-ext
Title: "EMS prenotification"
Description: "Indicates whether emergency medical services prenotified the receiving hospital before arrival."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/ems-prenotification-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: RequiredPostAcuteCareExt
Id: required-post-acute-care-ext
Title: "Required post-acute care"
Description: "Boolean indicator that post-acute care is required or applicable to the resource context. Used by Encounter, Observation and MedicationAdministration builders."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/required-post-acute-care-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* ^context[1].type = #element
* ^context[1].expression = "Observation"
* ^context[2].type = #element
* ^context[2].expression = "MedicationAdministration"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: PostAcuteCareRequiredExt
Id: post-acute-care-required-ext
Title: "Post-acute care required"
Description: "Boolean indicator used by Procedure builders to mark post-acute-care relevance. Semantically equivalent to required-post-acute-care-ext but kept because both URLs exist in the codebase."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/post-acute-care-required-ext"
* ^context[0].type = #element
* ^context[0].expression = "Procedure"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: DischargeDepartmentServiceExt
Id: discharge-department-service-ext
Title: "Discharge department or service"
Description: "Department, unit or service receiving the patient at discharge."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/discharge-department-service-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from DischargeFacilityDepartmentVS (extensible)
* valueCodeableConcept ^short = "Receiving department, unit or service at discharge"

Extension: DischargeFacilityTypeExt
Id: discharge-facility-type-ext
Title: "Discharge facility type"
Description: "Type of facility or transfer destination receiving the patient at discharge."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/discharge-facility-type-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from DischargeFacilityTypeVS (extensible)
* valueCodeableConcept ^short = "Type of facility or transfer destination after discharge"


Extension: InitialCareIntensityExt
Id: initial-care-intensity-ext
Title: "Initial care intensity"
Description: "Initial care intensity for hospitalized location, e.g. ICU/stroke unit, monitored bed, or standard bed."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/initial-care-intensity-ext"
* ^context[0].type = #element
* ^context[0].expression = "Location"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from HospitalizedInVS (required)

Extension: ObservationTimingContextExt
Id: observation-timing-context-ext
Title: "Observation timing context"
Description: "Temporal/clinical context of an observation, such as admission, discharge, prestroke or three-month follow-up. Also supports boolean usage because build_observation_blood_volume currently writes a boolean post_acute_care value to this URL."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/observation-timing-context-ext"
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* value[x] only CodeableConcept or boolean
* value[x] 1..1 MS
* valueCodeableConcept from AssessmentContextVS (extensible)

Extension: ProcedureTimingContextExt
Id: procedure-timing-context-ext
Title: "Procedure timing context"
Description: "Timing or phase context for procedure execution, such as acute/post-acute or specific screening window."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/procedure-timing-context-ext"
* ^context[0].type = #element
* ^context[0].expression = "Procedure"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from AssessmentContextVS (extensible)

Extension: AssessmentTimingExt
Id: assessment-timing-ext
Title: "Assessment or medication timing"
Description: "Timing category used by medication-administration builders, e.g. insulin within one hour or paracetamol timing. The Python code contains a typo variant tecnomod-um-org; this IG normalizes to tecnomod-um.org."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/assessment-timing-ext"
* ^context[0].type = #element
* ^context[0].expression = "MedicationAdministration"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS

Extension: IschemicStrokeEtiologyExt
Id: ischemic-stroke-etiology-ext
Title: "Ischemic stroke etiology"
Description: "Etiology of ischemic stroke, including undetermined when the etiology is not known."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/ischemic-stroke-etiology-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from StrokeEtiologyVS (required)

Extension: HemorrhagicStrokeBleedingReasonExt
Id: hemorrhagic-stroke-bleeding-reason-ext
Title: "Hemorrhagic stroke bleeding reason"
Description: "Reason or underlying cause identified for hemorrhagic stroke, including undetermined when no reason is found."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/hemorrhagic-stroke-bleeding-reason-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from BleedingReasonVS (required)

Extension: WakeupStrokeExt
Id: wakeup-stroke-ext
Title: "Wake-up stroke"
Description: "Boolean flag indicating that the stroke was first noticed after waking; onsetDateTime is then populated using the last-known-well/sleep timestamp in the builder."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/wakeup-stroke-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: QuestionnaireSkippedItemExt
Id: questionnaire-skipped-item-ext
Title: "Questionnaire item skipped"
Description: "Flags a questionnaire response item that the respondent skipped, distinguishing a deliberate skip from an item that was never presented. Replaces the legacy URL https://stroke.qualityregistry.org/fhir/StructureDefinition/questionnaire-skipped-item emitted by the RES-Q questionnaire service."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/questionnaire-skipped-item-ext"
* ^context[0].type = #element
* ^context[0].expression = "QuestionnaireResponse.item"
* value[x] only boolean
* valueBoolean 1..1 MS

// The window is carried as a Duration rather than a code so that any look-back
// length can be stated, not only the three the registry happened to calculate
// first. Duration is FHIR's Quantity specialization for time: its own invariant
// drt-1 requires a UCUM system whenever a code is present, and its unit binding
// is the UCUM time units, so the datatype already says most of what a coded
// window said. Observation.effectivePeriod still carries the actual calendar
// dates the readings were drawn from; this extension carries the nominal window,
// so that consumers can select all 30-day aggregations without date arithmetic.
Extension: AveragingWindowExt
Id: averaging-window-ext
Title: "Averaging window"
Description: "The look-back window an aggregated value expresses, as a whole number of UCUM time units: 30 days, 12 weeks, 6 months. Observation.effectivePeriod carries the actual calendar dates the readings were drawn from; this extension carries the nominal window so that consumers can select all 30-day aggregations without date arithmetic."
* ^url = "http://fhir.qualityregistry.org/StructureDefinition/averaging-window-ext"
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* value[x] only Duration
* valueDuration 1..1 MS
* valueDuration ^short = "Length of the averaging window, for example 30 days"
* valueDuration obeys avw-whole-number
// Duration leaves value, system and code all optional and drt-1 only bites when
// a code is present. A window is useless without all three, so each is required
// here and the system is pinned to UCUM rather than merely constrained by drt-1.
// Assigned as a pattern rather than with (exactly), because eld-24 recommends
// pattern[x] over fixed[x] and the two are equivalent for a uri primitive.
* valueDuration.value 1..1 MS
* valueDuration.value ^short = "Whole number of units, for example 30"
* valueDuration.system 1..1 MS
* valueDuration.system = "http://unitsofmeasure.org"
* valueDuration.code 1..1 MS
* valueDuration.code ^short = "UCUM time unit, for example d, wk or mo"
// A window is an exact length. "More than 30 days" is not a window a consumer
// could group aggregations by, so the comparator is removed.
* valueDuration.comparator 0..0

Invariant: avw-whole-number
Description: "An averaging window must be a positive whole number of units. Quantity.value is a decimal in FHIR and cannot be retyped to an integer, so the whole-number requirement is stated here instead."
Severity: #error
Expression: "value > 0 and value = value.truncate()"
