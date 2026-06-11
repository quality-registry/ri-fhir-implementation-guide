// -----------------------------------------------------------------------------
// Observation profiles
// -----------------------------------------------------------------------------

Profile: BaseStrokeObservation
Parent: Observation
Id: base-stroke-observation
Title: "Base Stroke Observation Profile"
Description: "Base profile for RES-Q stroke observations. It requires final status, patient, encounter and observation code so derived profiles share a consistent registry context."
* ^url = "http://tecnomod-um.org/StructureDefinition/base-stroke-observation"
* insert RESQProfileMetadata
* ^purpose = "Provides a common observation scaffold for stroke scores, process metrics, laboratory values, imaging findings and follow-up measurements."
* insert RESQObservationCore

Profile: VitalSignObservationProfile
Parent: BaseStrokeObservation
Id: vital-sign-observation-profile
Title: "Vital Sign Observation Profile"
Description: "Observation profile for vital signs in the acute stroke pathway, especially blood pressure components."
* ^url = "http://tecnomod-um.org/StructureDefinition/vital-sign-observation-profile"
* insert RESQProfileMetadata
* category 1..* MS
* category = ObservationCategoryCS#vital-signs
* category ^short = "Vital signs category"
* code from VitalSignsVS (extensible)
* component 1..* MS
* component ^short = "Vital-sign component such as systolic or diastolic blood pressure"
* component.code 1..1 MS
* component.code from VitalSignsVS (extensible)
* component.value[x] 1..1 MS
* component.value[x] only Quantity
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: FunctionalScoreObservationProfile
Parent: BaseStrokeObservation
Id: functional-score-observation-profile
Title: "Functional Score Observation Profile"
Description: "Observation profile for functional or severity scores such as mRS, NIHSS, ASPECTS, Hunt-Hess, ABCD2, CHA2DS2-VASc and THRIVE."
* ^url = "http://tecnomod-um.org/StructureDefinition/functional-score-observation-profile"
* insert RESQProfileMetadata
* category 0..* MS
* category from http://hl7.org/fhir/ValueSet/observation-category (preferred)
* code 1..1 MS
* code from FunctionalScoreVS (extensible)
* code ^short = "Functional or severity score instrument"
* value[x] 0..1 MS
* value[x] only integer or CodeableConcept or Quantity
* value[x] ^short = "Recorded score value"
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: GlasgowComaScoreObservationProfile
Parent: FunctionalScoreObservationProfile
Id: glasgow-coma-score-observation-profile
Title: "Glasgow Coma Score Observation Profile"
Description: "Specialized functional score profile for Glasgow Coma Score values captured by the registry."
* ^url = "http://tecnomod-um.org/StructureDefinition/glasgow-coma-score-observation-profile"
* insert RESQProfileMetadata
* code = SCT#248241002 "Glasgow coma score (observable entity)"
* value[x] 1..1 MS
* value[x] only integer

Profile: GlasgowComaScaleObservationProfile
Parent: FunctionalScoreObservationProfile
Id: glasgow-coma-scale-observation-profile
Title: "Glasgow Coma Scale Observation Profile"
Description: "Specialized functional score profile for Glasgow Coma Scale component values captured by the registry."
* ^url = "http://tecnomod-um.org/StructureDefinition/glasgow-coma-scale-observation-profile"
* insert RESQProfileMetadata
* code = SCT#386557006 "Glasgow coma scale finding (finding)"
* value[x] 1..1 MS
* value[x] only CodeableConcept
* derivedFrom 0..* MS
* derivedFrom only Reference(Observation)


Profile: SpecificFindingObservationProfile
Parent: BaseStrokeObservation
Id: specific-finding-observation-profile
Title: "Specific Finding Observation Profile"
Description: "Observation profile for specific stroke-related clinical, imaging and procedural findings including mTICI, bleeding volume, carotid stenosis, artery occlusion, atrial fibrillation/flutter and post-treatment findings."

* ^url = "http://tecnomod-um.org/StructureDefinition/specific-finding-observation-profile"
* insert RESQProfileMetadata

* obeys specific-finding-must-have-result
* obeys mtici-value-must-use-mtici-score-vs
* obeys blood-volume-must-be-quantity-ml
* obeys carotid-stenosis-value-rule
* obeys artery-occlusion-must-have-bodystructure
* obeys af-flutter-value-must-use-af-flutter-vs
* obeys hemorrhagic-transformation-value-rule

* status 1..1 MS
* status = #final

* subject 1..1 MS
* encounter 1..1 MS

* category 1..* MS
* category ^short = "Observation category, such as exam, procedure or laboratory"

* code 1..1 MS
* code from SpecificFindingVS (extensible)
* code ^short = "Specific stroke-related finding"

* value[x] 0..1 MS
* value[x] only boolean or CodeableConcept or Quantity
* value[x] ^short = "Finding value"

* valueBoolean MS
* valueBoolean ^short = "Presence or absence of the finding"

* valueCodeableConcept MS
* valueCodeableConcept from SpecificFindingValueVS (extensible)
* valueCodeableConcept ^short = "Coded finding value, such as mTICI score, AF/flutter status, carotid stenosis level or hemorrhagic transformation type"

* valueQuantity MS
* valueQuantity ^short = "Quantitative finding value, such as bleeding volume"
* valueQuantity.value 1..1 MS
* valueQuantity.system 1..1 MS
* valueQuantity.code 1..1 MS
* valueQuantity.unit 0..1 MS

* bodySite 0..1 MS
* bodySite ^short = "Anatomical site when a simple coded body site is sufficient"

* bodyStructure 0..1 MS
* bodyStructure only Reference(RESQBodyStructureProfile)
* bodyStructure ^short = "Patient-specific anatomical structure associated with the finding"

* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Invariant: specific-finding-must-have-result
Description: "A specific finding observation should have either a value or a dataAbsentReason."
Severity: #error
Expression: "value.exists() or dataAbsentReason.exists()"

Invariant: mtici-value-must-use-mtici-score-vs
Description: "If Observation.code is mTICI, valueCodeableConcept must belong to MTiciScoreVS."
Severity: #error
Expression: "code.coding.where(system = 'http://tecnomod-um.org/CodeSystem/mtici-code-cs' and code = 'mTICI').exists().not() or (value.ofType(CodeableConcept).exists() and value.ofType(CodeableConcept).memberOf('http://tecnomod-um.org/ValueSet/mtici-score-vs'))"

Invariant: blood-volume-must-be-quantity-ml
Description: "If Observation.code is blood volume, valueQuantity must be expressed in UCUM milliliters."
Severity: #error
Expression: "code.coding.where(system = 'http://snomed.info/sct' and code = '16086006').exists().not() or (value.ofType(Quantity).exists() and value.ofType(Quantity).system = 'https://ucum.org/ucum' and value.ofType(Quantity).code = 'mL')"

Invariant: carotid-stenosis-value-rule
Description: "If Observation.code is carotid stenosis, the value must be either a boolean presence/absence value or a coded carotid stenosis level."
Severity: #error
Expression: "code.coding.where(system = 'http://snomed.info/sct' and (code = '64586002' or code = '787044009')).exists().not() or value.ofType(boolean).exists() or value.ofType(CodeableConcept).memberOf('http://tecnomod-um.org/ValueSet/carotid-stenosis-level-vs')"

Invariant: artery-occlusion-must-have-bodystructure
Description: "If Observation.code is artery occlusion, valueBoolean must be true and bodyStructure must be present."
Severity: #error
Expression: "code.coding.where(system = 'http://snomed.info/sct' and code = '2929001').exists().not() or (value.ofType(boolean) = true and bodyStructure.exists())"

Invariant: hemorrhagic-transformation-value-rule
Description: "If Observation.code is hemorrhagic transformation, the value must be either a boolean presence/absence value or a coded hemorrhagic transformation type."
Severity: #error
Expression: "code.coding.where(system = 'http://snomed.info/sct' and code = '230706003').exists().not() or value.ofType(boolean).exists() or value.ofType(CodeableConcept).memberOf('http://tecnomod-um.org/ValueSet/hemorrhagic-transformation-type-vs')"

Invariant: af-flutter-value-must-use-af-flutter-vs
Description: "If Observation.code is atrial fibrillation/flutter status, valueCodeableConcept must belong to AtrialFibrillationOrFlutterVS."
Severity: #error
Expression: "code.coding.where(system = 'http://tecnomod-um.org/CodeSystem/specific-finding-cs' and code = 'atrial-fibrillation-flutter').exists().not() or (value.ofType(CodeableConcept).exists() and value.ofType(CodeableConcept).memberOf('http://tecnomod-um.org/ValueSet/atrial-fibrillation-or-flutter-vs'))"


Profile: TimingMetricObservationProfile
Parent: BaseStrokeObservation
Id: timing-metric-observation-profile
Title: "Timing Metric Observation Profile"
Description: "Observation profile for stroke time metrics and process indicators such as door-to-needle, door-to-groin, onset-to-door and related measures."
* ^url = "http://tecnomod-um.org/StructureDefinition/timing-metric-observation-profile"
* insert RESQProfileMetadata
* code 1..1 MS
* code from TimingMetricCodesVS (required)
* code ^short = "Timing or process metric"
* value[x] 1..1 MS
* value[x] only Quantity or boolean 
* value[x] ^short = "Metric duration/value or yes/no indicator"
* partOf 0..* MS
* partOf only Reference(Procedure or MedicationAdministration)
* partOf ^short = "Procedure or administration measured by this timing metric"

Profile: AnaliticsObservationProfile
Parent: BaseStrokeObservation
Id: analitics-observation-profile
Title: "Analytics Observation Profile"
Description: "Laboratory/analytics observation profile for glucose, cholesterol, INR and related findings. The id preserves the original spelling used in the Python profile URL."
* ^url = "http://tecnomod-um.org/StructureDefinition/analytics-observation-profile"
* insert RESQProfileMetadata
* category 0..* MS
* code 1..1 MS
* code from AnaliticsCodesVS (extensible)
* code ^short = "Laboratory or analytics concept"
* value[x] 0..1 MS
* value[x] only Quantity or CodeableConcept or boolean
* value[x] ^short = "Laboratory value or coded/boolean result"
* method 0..1 MS
* method from INRmodeVS (extensible)
* method ^short = "Measurement or assessment method"
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: FeverObservationProfile
Parent: BaseStrokeObservation
Id: fever-observation-profile
Title: "Fever Observation Profile"
Description: "Observation profile for fever presence or temperature values during the stroke pathway."
* ^url = "http://tecnomod-um.org/StructureDefinition/fever-observation-profile"
* insert RESQProfileMetadata
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean or Quantity
* value[x] ^short = "Fever indicator or temperature measurement"
* extension contains ObservationTimingContextExt named observationTimingContext 0..1 MS

Profile: HyperglycemiaObservationProfile
Parent: BaseStrokeObservation
Id: hyperglycemia-observation-profile
Title: "Hyperglycemia Observation Profile"
Description: "Observation profile for hyperglycemia monitoring, checks and measured values."
* ^url = "http://tecnomod-um.org/StructureDefinition/hyperglycemia-observation-profile"
* insert RESQProfileMetadata
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean or Quantity or integer
* value[x] ^short = "Hyperglycemia indicator or measured value"


Profile: GlucoseGE10ObservationProfile
Parent: BaseStrokeObservation
Id: glucose-ge10-observation-profile
Title: "Glucose >= 10 Observation Profile"
Description: "Boolean observation profile indicating whether glucose was greater than or equal to 10 mmol/L."
* ^url = "http://tecnomod-um.org/StructureDefinition/glucose-ge10-observation-profile"
* insert RESQProfileMetadata
* code from AnaliticsCodesVS (extensible)
* value[x] only boolean
* valueBoolean 1..1 MS
* valueBoolean ^short = "Glucose >= 10 mmol/L indicator"

Profile: HighestHyperglycemiaValueObservationProfile
Parent: BaseStrokeObservation
Id: highest-hyperglycemia-value-observation-profile
Title: "Highest Hyperglycemia Value Observation Profile"
Description: "Observation profile for the highest recorded hyperglycemia value in the relevant stroke care interval."
* ^url = "http://tecnomod-um.org/StructureDefinition/highest-hyperglycemia-value-observation-profile"
* insert RESQProfileMetadata
* code = AnalyticsCodesCS#highest-hyperglycemia-value "Highest Hyperglycemia Value"
* value[x] only Quantity
* valueQuantity 1..1 MS
* valueQuantity ^short = "Highest glucose value"
* extension contains ObservationTimingContextExt named observationTimingContext 1..1 MS

Profile: SystolicBloodPressureHighestValueObservationProfile
Parent: BaseStrokeObservation
Id: highest-systolic-blood-pressure-value-observation-profile
Title: "Systolic Blood Pressure Highest Value Observation Profile"
Description: "Observation profile for the highest recorded systolic blood pressure value in the relevant stroke care interval."
* ^url = "http://tecnomod-um.org/StructureDefinition/highest-systolic-blood-pressure-value-observation-profile"
* insert RESQProfileMetadata
* code = VitalSignsCS#highest-sys-bp "Highest Systolic Blood Pressure"
* value[x] only Quantity
* valueQuantity 1..1 MS
* valueQuantity ^short = "Highest systolic blood pressure value"
* extension contains ObservationTimingContextExt named observationTimingContext 1..1 MS


Profile: TIAClinicalSymptomsObservationProfile
Parent: BaseStrokeObservation
Id: tia-clinical-symptoms-observation-profile
Title: "TIA Clinical Symptoms Observation Profile"
Description: "Observation profile for TIA clinical symptoms and their recorded values."
* ^url = "http://tecnomod-um.org/StructureDefinition/tia-clinical-symptoms-observation-profile"
* insert RESQProfileMetadata
* code from TiaClinicalSymptomsVS (extensible)
* value[x] 0..1 MS
* value[x] only Quantity or CodeableConcept or boolean
* value[x] ^short = "TIA symptom value, duration or indicator"

Profile: PatientVentilatedObservationProfile
Parent: BaseStrokeObservation
Id: patient-ventilated-observation-profile
Title: "Patient Ventilated Observation Profile"
Description: "Observation profile for recording whether the patient was ventilated in acute or post-acute care."
* ^url = "http://tecnomod-um.org/StructureDefinition/patient-ventilated-observation-profile"
* insert RESQProfileMetadata
* code = SCT#40617009 "Artificial ventilation (regime/therapy)"
* value[x] only boolean
* valueBoolean 1..1 MS
* valueBoolean ^short = "Patient ventilated indicator"
* extension contains RequiredPostAcuteCareExt named requiredPostAcuteCare 0..1 MS


Profile: NoAnticoagulantDischargeReasonObservationProfile
Parent: BaseStrokeObservation
Id: no-anticoagulant-discharge-reason-observation-profile
Title: "No Anticoagulant Discharge Reason Observation Profile"
Description: "Observation profile for recording the reason for not prescribing anticoagulants at discharge after ischemic stroke or TIA."
* ^url = "http://tecnomod-um.org/StructureDefinition/no-anticoagulant-discharge-reason-observation-profile"
* insert RESQProfileMetadata
* code from NotMedicationReasonVS (extensible)
* value[x] only CodeableConcept
* value[x] ^short = "Reason for no anticoagulant prescription at discharge"


Profile: ThreeMonthContactModeObservationProfile
Parent: BaseStrokeObservation
Id: three-month-contact-mode-observation-profile
Title: "Three-Month Contact Mode Observation Profile"
Description: "Observation profile for the modality used to obtain three-month follow-up information."
* ^url = "http://tecnomod-um.org/StructureDefinition/three-month-contact-mode-observation-profile"
* insert RESQProfileMetadata
* code from ThreeMonthContactModeVS (required)
* code ^short = "Three-month contact mode"

Profile: AppointmentManagementObservationProfile
Parent: BaseStrokeObservation
Id: appointment-management-observation-profile
Title: "Appointment Management Observation Profile"
Description: "Observation profile for recording whether a three-month follow-up appointment was scheduled or attended."
* ^url = "http://tecnomod-um.org/StructureDefinition/appointment-management-observation-profile"
* insert RESQProfileMetadata
* code from ManagementAppointmentVS (extensible)