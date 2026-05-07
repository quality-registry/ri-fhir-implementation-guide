// -----------------------------------------------------------------------------
// Clinical condition and observation profiles
// -----------------------------------------------------------------------------

Profile: StrokeDiagnosisConditionProfile
Parent: Condition
Id: stroke-diagnosis-condition-profile
Title: "Stroke Diagnosis Condition Profile"
Description: "Index stroke diagnosis profile aligned with build_stroke_diagnosis_condition_profile()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-diagnosis-condition-profile"
* ^status = #active
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* clinicalStatus 1..1 MS
* clinicalStatus = ConditionClinicalCS#active
* verificationStatus 1..1 MS
* verificationStatus from http://hl7.org/fhir/ValueSet/condition-ver-status (required)
* code 1..1 MS
* code from StrokeTypeVS (extensible)
* bodySite 0..* MS
* bodySite from BodySitesVS (extensible)
* evidence 0..* MS
* onset[x] 0..1 MS
* onset[x] only dateTime
* extension contains IschemicStrokeEtiologyExt named ischemicStrokeEtiology 0..1 MS
  and IschemicStrokeEtiologyKnownExt named ischemicStrokeEtiologyKnown 0..1 MS
  and HemorrhagicStrokeBleedingReasonExt named hemorrhagicStrokeBleedingReason 0..1 MS
  and HemorrhagicStrokeBleedingReasonFoundExt named hemorrhagicStrokeBleedingReasonFound 0..1 MS
  and WakeupStrokeExt named wakeupStroke 1..1 MS

Profile: StrokeRiskFactorConditionProfile
Parent: Condition
Id: stroke-risk-factor-condition-profile
Title: "Stroke Risk Factor Condition Profile"
Description: "Risk factor Condition profile aligned with build_risk_factor_condition_profile()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-risk-factor-condition-profile"
* ^status = #active
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* clinicalStatus 1..1 MS
* clinicalStatus from ClinicalStatusCodesVS (required)
* verificationStatus 0..1 MS
* code 1..1 MS
* code from RiskFactorVS (extensible)

Profile: PostStrokeComplicationConditionProfile
Parent: Condition
Id: post-stroke-complication-condition-profile
Title: "Post-Stroke Complication Condition Profile"
Description: "Post-stroke complication Condition profile aligned with build_post_stroke_conditions()."
* ^url = "http://tecnomod-um.org/StructureDefinition/post-stroke-complication-condition-profile"
* ^status = #active
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* clinicalStatus 1..1 MS
* clinicalStatus from ClinicalStatusCodesVS (required)
* code 1..1 MS
* code from PostStrokeComplicationsVS (extensible)

Profile: BaseStrokeObservation
Parent: Observation
Id: base-stroke-observation
Title: "Base Stroke Observation Profile"
Description: "Base profile for stroke registry observations: subject and encounter required; status is normally final."
* ^url = "http://tecnomod-um.org/StructureDefinition/base-stroke-observation"
* ^status = #active
* status 1..1 MS
* status = #final
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS

Profile: VitalSignObservationProfile
Parent: BaseStrokeObservation
Id: vital-sign-observation-profile
Title: "Vital Sign Observation Profile"
Description: "Blood pressure observation aligned with build_observation_vital_signs()."
* ^url = "http://tecnomod-um.org/StructureDefinition/vital-sign-observation-profile"
* category 1..* MS
* category = ObservationCategoryCS#vital-signs
* code from VitalSignsVS (extensible)
* component 1..* MS
* component.code 1..1 MS
* component.code from VitalSignsVS (extensible)
* component.value[x] 1..1 MS
* component.value[x] only Quantity
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: FunctionalScoreObservationProfile
Parent: BaseStrokeObservation
Id: functional-score-observation-profile
Title: "Functional Score Observation Profile"
Description: "Functional score profile for mRS, NIHSS, ASPECTS, GCS-like score categories, Hunt-Hess, ABCD2, CHA2DS2-VASc and THRIVE."
* ^url = "http://tecnomod-um.org/StructureDefinition/functional-score-observation-profile"
* category 0..* MS
* category from http://hl7.org/fhir/ValueSet/observation-category (preferred)
* code 1..1 MS
* code from FunctionalScoreVS (extensible)
* value[x] 0..1 MS
* value[x] only integer or CodeableConcept or Quantity
* valueCodeableConcept from MRsScoreVS (extensible)
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: GlasgowComaScaleObservationProfile
Parent: FunctionalScoreObservationProfile
Id: glasgow-coma-scale-observation-profile
Title: "Glasgow Coma Scale Observation Profile"
Description: "GCS score/profile generated from build_observation_glasgow_coma_scale()."
* ^url = "http://tecnomod-um.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* code from GlasgowComaScaleVS (extensible)
* value[x] only integer or CodeableConcept
* valueCodeableConcept from GCSScoreVS (extensible)

Profile: SpecificFindingObservationProfile
Parent: BaseStrokeObservation
Id: specific-finding-observation-profile
Title: "Specific Finding Observation Profile"
Description: "Generic profile for specific imaging/procedure/clinical findings including mTICI, bleeding volume, carotid stenosis, occlusion and AF/flutter."
* ^url = "http://tecnomod-um.org/StructureDefinition/specific-finding-observation-profile"
* category 0..* MS
* code 1..1 MS
* code from SpecificFindingVS (extensible)
* value[x] 0..1 MS
* value[x] only boolean or integer or CodeableConcept or Quantity
* bodyStructure 0..1 MS
* bodyStructure only Reference(RESQBodyStructureProfile)
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: TimingMetricObservationProfile
Parent: BaseStrokeObservation
Id: timing-metric-observation-profile
Title: "Timing Metric Observation Profile"
Description: "Timing/process metric profile for door-to-needle, door-to-groin, onset-to-door and related indicators."
* ^url = "http://tecnomod-um.org/StructureDefinition/timing-metric-observation-profile"
* code 1..1 MS
* code from TimingMetricCodesVS (required)
* value[x] 1..1 MS
* value[x] only Quantity or boolean
* valueQuantity.system 0..1 MS
* valueQuantity.code 0..1 MS
* partOf 0..* MS
* partOf only Reference(Procedure or MedicationAdministration)

Profile: AnaliticsObservationProfile
Parent: BaseStrokeObservation
Id: analitics-observation-profile
Title: "Analytics Observation Profile"
Description: "Laboratory/analytics observations for glucose, cholesterol, INR and related laboratory findings. The id preserves the original spelling used in the Python profile URL."
* ^url = "http://tecnomod-um.org/StructureDefinition/analitics-observation-profile"
* category 0..* MS
* code 1..1 MS
* code from AnaliticsCodesVS (extensible)
* value[x] 0..1 MS
* value[x] only Quantity or CodeableConcept or boolean
* method 0..1 MS
* method from ObservationMethodsVS (extensible)
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: FeverObservationProfile
Parent: BaseStrokeObservation
Id: fever-observation-profile
Title: "Fever Observation Profile"
Description: "Fever observation profile aligned with build_observation_fever()."
* ^url = "http://tecnomod-um.org/StructureDefinition/fever-observation-profile"
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean or Quantity
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: HyperglycemiaObservationProfile
Parent: BaseStrokeObservation
Id: hyperglycemia-observation-profile
Title: "Hyperglycemia Observation Profile"
Description: "Hyperglycemia monitoring/check observations aligned with build_observation_hyperglycemia_measurement_checks()."
* ^url = "http://tecnomod-um.org/StructureDefinition/hyperglycemia-observation-profile"
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean or Quantity or integer

Profile: GlucoseGE10ObservationProfile
Parent: BaseStrokeObservation
Id: glucose-ge10-observation-profile
Title: "Glucose >= 10 Observation Profile"
Description: "Boolean indicator for glucose >= 10 mmol/L."
* ^url = "http://tecnomod-um.org/StructureDefinition/glucose-ge10-observation-profile"
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean
* valueBoolean 1..1 MS

Profile: HighestHyperglycemiaValueObservationProfile
Parent: BaseStrokeObservation
Id: highest-hyperglycemia-value-observation-profile
Title: "Highest Hyperglycemia Value Observation Profile"
Description: "Highest hyperglycemia value observation profile."
* ^url = "http://tecnomod-um.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* code from AnaliticsCodesVS (extensible)
* value[x] only Quantity
* valueQuantity 1..1 MS
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: TIAClinicalSymptomsObservationProfile
Parent: BaseStrokeObservation
Id: tia-clinical-symptoms-observation-profile
Title: "TIA Clinical Symptoms Observation Profile"
Description: "TIA symptoms observation profile aligned with build_tia_clinical_symptomps_observation()."
* ^url = "http://tecnomod-um.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* code from TiaClinicalSymptomsVS (extensible)
* value[x] 0..1 MS
* value[x] only Quantity or CodeableConcept or boolean

Profile: PatientVentilatedObservationProfile
Parent: BaseStrokeObservation
Id: patient-ventilated-observation-profile
Title: "Patient Ventilated Observation Profile"
Description: "Ventilation observation profile for post-acute/acute context."
* ^url = "http://tecnomod-um.org/StructureDefinition/patient-ventilated-observation-profile"
* code from ObservationMethodsVS (extensible)
* value[x] only boolean
* extension contains RequiredPostAcuteCareExt named requiredPostAcuteCare 0..1 MS

Profile: ThreeMonthContactModeObservationProfile
Parent: BaseStrokeObservation
Id: three-month-contact-mode-observation-profile
Title: "Three-Month Contact Mode Observation Profile"
Description: "Observation profile for contact mode at three-month follow-up."
* ^url = "http://tecnomod-um.org/StructureDefinition/three-month-contact-mode-observation-profile"
* code from ThreeMonthContactModeVS (required)
