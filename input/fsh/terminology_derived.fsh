// -----------------------------------------------------------------------------
// Terminology for derived (calculated) observations
//
// Hand-authored, deliberately kept out of terminology_generated.fsh so a
// regeneration from enum_models.py cannot clobber it, in the same way as
// terminology_selfreported.fsh.
//
// The averages themselves need no local codes: SNOMED CT International has
// 314440001 and 314453003 for average systolic and average diastolic blood
// pressure, both children of 723232008 "Average blood pressure", which is the
// panel code the profile uses. What SNOMED has no concept for is blood-pressure
// time in range: searching the 2026-09 International Edition for "time in
// target range" returns nothing, so bp-time-in-range below is local, following
// the precedent of highest-sys-bp and highest-hyperglycemia-value.
//
// The calculated concepts are collected in SelfReportedValueAggregationVS
// below, which binds Observation.code on the aggregation profile. The control
// status enumerations that follow it are the registry's judgements about the
// data, carried in Observation.interpretation rather than as codes of their own
// observation: SelfReportedAggregationStatusVS on the aggregation profile,
// SelfReportedReadingStatusVS on the readings profile.
// -----------------------------------------------------------------------------

CodeSystem: DerivedObservationCS
Id: derived-observation-cs
Title: "DerivedObservation CodeSystem"
Description: "Local codes for derived observation concepts that have no SNOMED CT International equivalent."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/derived-observation-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #bp-time-in-range "Blood pressure time in range"
* #bp-time-in-range ^definition = "Proportion of the patient's self-reported blood-pressure readings in the averaging window that fell within the treatment target, expressed as a percentage. A reading counts as in range only when its systolic and diastolic values are both within target."

CodeSystem: AveragingWindowCS
Id: averaging-window-cs
Title: "AveragingWindow CodeSystem"
Description: "Length of the look-back window over which self-reported readings were aggregated."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/averaging-window-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #7-day "7-day window"
* #7-day ^definition = "Averaged over the 7 days preceding the end of the observation period."
* #14-day "14-day window"
* #14-day ^definition = "Averaged over the 14 days preceding the end of the observation period."
* #30-day "30-day window"
* #30-day ^definition = "Averaged over the 30 days preceding the end of the observation period."

// The calculating service emits these codes in an upper-case, underscore-separated
// form (WITHIN_ESC_TREATMENT_TARGET and so on). They are normalized here to the
// kebab-case every other local CodeSystem in this guide uses, and caseSensitive is
// false to match, following the precedent set for the questionnaire service's
// observation codes in terminology_selfreported.fsh. The calculating service must
// be migrated onto these codes for the two sides to agree at source.
CodeSystem: BloodPressureRiskStatusCS
Id: blood-pressure-risk-status-cs
Title: "BloodPressureRiskStatus CodeSystem"
Description: "Overall risk assessment of a derived blood-pressure average. Each code is a single independent statement about the patient's blood-pressure control over the averaging window."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/blood-pressure-risk-status-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #within-esc-treatment-target "Within ESC treatment target"
* #within-esc-treatment-target ^definition = "The averaged blood pressure lies within the European Society of Cardiology treatment target for this patient."
* #above-esc-treatment-target "Above ESC treatment target"
* #above-esc-treatment-target ^definition = "The averaged blood pressure exceeds the European Society of Cardiology treatment target for this patient."
* #above-home-hypertension-threshold "Above home hypertension threshold"
* #above-home-hypertension-threshold ^definition = "The averaged blood pressure exceeds the diagnostic threshold for hypertension applied to home measurements, which is lower than the office threshold."
* #repeated-severe-elevation "Repeated severe elevation"
* #repeated-severe-elevation ^definition = "Severely elevated readings occurred repeatedly within the averaging window, warranting clinical attention regardless of the average itself."
* #target-adjusted-for-age "Target adjusted for age"
* #target-adjusted-for-age ^definition = "The treatment target the average was assessed against was adjusted for the patient's age. The adjusted numeric target is not carried on the resource; this code is the only record that an adjustment was applied."
* #insufficient-data "Insufficient data"
* #insufficient-data ^definition = "Too few readings were reported in the window for the average to support a risk assessment. The averages and the time-in-range percentage are still computed and present."

// The two analyte status enumerations. They are separate CodeSystems, one per
// analyte, so each can evolve on its own; within-target, above-optimal-target
// and above-recommended-target therefore appear in both, as distinct concepts
// in distinct systems rather than as one shared code. Codes are normalized to
// kebab-case and caseSensitive is false, as in BloodPressureRiskStatusCS.
CodeSystem: GlucoseRiskStatusCS
Id: glucose-risk-status-cs
Title: "GlucoseRiskStatus CodeSystem"
Description: "Assessment of a patient's glucose control, derived from their latest self-reported glucose reading. Each code is a single independent statement."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/glucose-risk-status-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #glucose-value-missing "Glucose value missing"
* #glucose-value-missing ^definition = "No self-reported glucose reading is available to assess."
* #below-target-hypoglycemia-risk "Below target, hypoglycemia risk"
* #below-target-hypoglycemia-risk ^definition = "The latest reading is below the target range, putting the patient at risk of hypoglycemia."
* #within-target "Within target"
* #within-target ^definition = "The latest reading lies within the target range."
* #above-optimal-target "Above optimal target"
* #above-optimal-target ^definition = "The latest reading exceeds the optimal target but not the recommended treatment target."
* #above-recommended-target "Above recommended target"
* #above-recommended-target ^definition = "The latest reading exceeds the recommended treatment target."

CodeSystem: CholesterolRiskStatusCS
Id: cholesterol-risk-status-cs
Title: "CholesterolRiskStatus CodeSystem"
Description: "Assessment of a patient's LDL cholesterol control, derived from their latest self-reported LDL reading. Each code is a single independent statement."
* ^url = "http://fhir.qualityregistry.org/CodeSystem/cholesterol-risk-status-cs"
* ^status = #active
* ^experimental = false
* ^caseSensitive = false
* #ldl-value-missing "LDL value missing"
* #ldl-value-missing ^definition = "No self-reported LDL cholesterol reading is available to assess."
* #within-target "Within target"
* #within-target ^definition = "The latest reading lies within the target range."
* #above-optimal-target "Above optimal target"
* #above-optimal-target ^definition = "The latest reading exceeds the optimal target but not the recommended treatment target."
* #above-recommended-target "Above recommended target"
* #above-recommended-target ^definition = "The latest reading exceeds the recommended treatment target."

// Observation.code for the two derived profiles. They are deliberately two
// value sets rather than one: each profile binds only its own, so a measurement
// resource cannot carry a status concept and a status resource cannot carry a
// measurement concept. Both are held apart from SelfReportedSignsVS in
// terminology_selfreported.fsh, which holds only the readings a patient reports.
ValueSet: SelfReportedValueAggregationVS
Id: self-reported-value-aggregation-vs
Title: "SelfReportedValueAggregation ValueSet"
Description: "Figures the registry calculates from a patient's self-reported readings, used as the aggregation concept and as its component concepts."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-value-aggregation-vs"
* ^status = #active
* ^experimental = false
* include SCT#723232008 "Average blood pressure (observable entity)"
* include SCT#314440001 "Average systolic blood pressure (observable entity)"
* include SCT#314453003 "Average diastolic blood pressure (observable entity)"
* include DerivedObservationCS#bp-time-in-range "Blood pressure time in range"

ValueSet: GlucoseRiskStatusVS
Id: glucose-risk-status-vs
Title: "GlucoseRiskStatus ValueSet"
Description: "Assessments of a patient's glucose control."
* ^url = "http://fhir.qualityregistry.org/ValueSet/glucose-risk-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system GlucoseRiskStatusCS

ValueSet: CholesterolRiskStatusVS
Id: cholesterol-risk-status-vs
Title: "CholesterolRiskStatus ValueSet"
Description: "Assessments of a patient's LDL cholesterol control."
* ^url = "http://fhir.qualityregistry.org/ValueSet/cholesterol-risk-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system CholesterolRiskStatusCS

// The two bindings for Observation.interpretation, split by what was assessed.
// Blood pressure is only ever judged from an aggregate - its codes speak of the
// average and of repeated elevation across a window - so it binds the
// aggregation profile. Glucose and LDL cholesterol are judged from the latest
// reading, so they bind the readings profile. The pairing follows
// SpecificFindingValueVS and its per-finding siblings.
ValueSet: SelfReportedAggregationStatusVS
Id: self-reported-aggregation-status-vs
Title: "SelfReportedAggregationStatus ValueSet"
Description: "Every assessment the registry can record against aggregated self-reported readings. Blood pressure is the only subject the registry aggregates."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-aggregation-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system BloodPressureRiskStatusCS

ValueSet: SelfReportedReadingStatusVS
Id: self-reported-reading-status-vs
Title: "SelfReportedReadingStatus ValueSet"
Description: "Every assessment the registry can record against a self-reported reading itself, across glucose and LDL cholesterol."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-reading-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system GlucoseRiskStatusCS
* include codes from system CholesterolRiskStatusCS

ValueSet: AveragingWindowVS
Id: averaging-window-vs
Title: "AveragingWindow ValueSet"
Description: "The three look-back windows over which self-reported readings are aggregated."
* ^url = "http://fhir.qualityregistry.org/ValueSet/averaging-window-vs"
* ^status = #active
* ^experimental = false
* include codes from system AveragingWindowCS
