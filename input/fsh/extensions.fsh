// -----------------------------------------------------------------------------
// RESQ Stroke Registry Extensions
// -----------------------------------------------------------------------------

Extension: GenderSnomedExt
Id: gender-snomed-ext
Title: "Gender represented with SNOMED CT"
Description: "Sex/gender value as a SNOMED CT CodeableConcept, matching build_Patient()."
* ^url = "http://tecnomod-um.org/StructureDefinition/gender-snomed-ext"
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from SexVS (required)

Extension: FirstHospitalExt
Id: first-hospital-ext
Title: "First hospital for the stroke episode"
Description: "Boolean flag indicating whether the Encounter corresponds to the first hospital attended for the index stroke episode."
* ^url = "http://tecnomod-um.org/StructureDefinition/first-hospital-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only boolean
* valueReference 1..1 MS

Extension: EmsPrenotificationExt
Id: ems-prenotification-ext
Title: "EMS prenotification"
Description: "Indicates whether emergency medical services prenotified the receiving hospital before arrival."
* ^url = "http://tecnomod-um.org/StructureDefinition/ems-prenotification-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: RequiredPostAcuteCareExt
Id: required-post-acute-care-ext
Title: "Required post-acute care"
Description: "Boolean indicator that post-acute care is required or applicable to the resource context. Used by Encounter, Observation and MedicationAdministration builders."
* ^url = "http://tecnomod-um.org/StructureDefinition/required-post-acute-care-ext"
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
* ^url = "http://tecnomod-um.org/StructureDefinition/post-acute-care-required-ext"
* ^context[0].type = #element
* ^context[0].expression = "Procedure"
* value[x] only boolean
* valueBoolean 1..1 MS

Extension: DischargeDepartmentServiceExt
Id: discharge-department-service-ext
Title: "Discharge department or service"
Description: "Department/service or facility type receiving the patient at discharge."
* ^url = "http://tecnomod-um.org/StructureDefinition/discharge-department-service-ext"
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from DischargeFacilityDepartmentVS (extensible)

Extension: InitialCareIntensityExt
Id: initial-care-intensity-ext
Title: "Initial care intensity"
Description: "Initial care intensity for hospitalized location, e.g. ICU/stroke unit, monitored bed, or standard bed."
* ^url = "http://tecnomod-um.org/StructureDefinition/initial-care-intensity-ext"
* ^context[0].type = #element
* ^context[0].expression = "Location"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from HospitalizedInVS (required)

Extension: ObservationTimingContextExt
Id: observation-timing-context-ext
Title: "Observation timing context"
Description: "Temporal/clinical context of an observation, such as admission, discharge, prestroke or three-month follow-up. Also supports boolean usage because build_observation_blood_volume currently writes a boolean post_acute_care value to this URL."
* ^url = "http://tecnomod-um.org/StructureDefinition/observation-timing-context-ext"
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* value[x] only CodeableConcept or boolean
* value[x] 1..1 MS
* valueCodeableConcept from AssessmentContextVS (extensible)

Extension: ProcedureTimingContextExt
Id: procedure-timing-context-ext
Title: "Procedure timing context"
Description: "Timing or phase context for procedure execution, such as acute/post-acute or specific screening window."
* ^url = "http://tecnomod-um.org/StructureDefinition/procedure-timing-context-ext"
* ^context[0].type = #element
* ^context[0].expression = "Procedure"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from AssessmentContextVS (extensible)

Extension: AssessmentTimingExt
Id: assessment-timing-ext
Title: "Assessment or medication timing"
Description: "Timing category used by medication-administration builders, e.g. insulin within one hour or paracetamol timing. The Python code contains a typo variant tecnomod-um-org; this IG normalizes to tecnomod-um.org."
* ^url = "http://tecnomod-um.org/StructureDefinition/assessment-timing-ext"
* ^context[0].type = #element
* ^context[0].expression = "MedicationAdministration"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS

Extension: IschemicStrokeEtiologyExt
Id: ischemic-stroke-etiology-ext
Title: "Ischemic stroke etiology"
Description: "Etiology of ischemic stroke when known."
* ^url = "http://tecnomod-um.org/StructureDefinition/ischemic-stroke-etiology-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from StrokeEtiologyVS (required)

Extension: IschemicStrokeEtiologyKnownExt
Id: ischemic-stroke-etiology-known-ext
Title: "Ischemic stroke etiology known/unknown coded state"
Description: "Coded state used when the Python builder represents unknown or undetermined ischemic stroke etiology."
* ^url = "http://tecnomod-um.org/StructureDefinition/ischemic-stroke-etiology-known-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from StrokeEtiologyVS (required)

Extension: HemorrhagicStrokeBleedingReasonExt
Id: hemorrhagic-stroke-bleeding-reason-ext
Title: "Hemorrhagic stroke bleeding reason"
Description: "Reason or underlying cause identified for hemorrhagic stroke."
* ^url = "http://tecnomod-um.org/StructureDefinition/hemorrhagic-stroke-bleeding-reason-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from BleedingReasonVS (required)

Extension: HemorrhagicStrokeBleedingReasonFoundExt
Id: hemorrhagic-stroke-bleeding-reason-found-ext
Title: "Hemorrhagic stroke bleeding reason found coded state"
Description: "Coded state used when bleeding reason is not found/undetermined in the source model."
* ^url = "http://tecnomod-um.org/StructureDefinition/hemorrhagic-stroke-bleeding-reason-found-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from BleedingReasonVS (required)

Extension: WakeupStrokeExt
Id: wakeup-stroke-ext
Title: "Wake-up stroke"
Description: "Boolean flag indicating that the stroke was first noticed after waking; onsetDateTime is then populated using the last-known-well/sleep timestamp in the builder."
* ^url = "http://tecnomod-um.org/StructureDefinition/wakeup-stroke-ext"
* ^context[0].type = #element
* ^context[0].expression = "Condition"
* value[x] only boolean
* valueBoolean 1..1 MS
