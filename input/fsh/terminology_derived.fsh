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
// below, which binds Observation.code on the aggregation profile. The registry's
// judgement about the data is carried in Observation.interpretation using the
// standard HL7 ObservationInterpretation codes collected in
// SelfReportedInterpretationVS, bound on both the readings and the aggregation
// profile.
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

// Observation.interpretation on both self-reported profiles. Rather than local
// status enumerations, the registry's assessment is expressed with the standard
// HL7 ObservationInterpretation codes, so any consumer that understands
// interpretation flags can read it without registry-specific terminology. The
// analyte the flag applies to is already given by Observation.code.
//
// HU / LU mark values significantly outside the target; HH / LL are kept for
// critical values only. LU and LL are included for symmetry and are not
// currently produced by any assessment.
//
// IND covers data that was assessed but supports no verdict, such as too few
// blood-pressure readings in the window, or values the registry declines to
// interpret because of low confidence in them. IE (insufficient evidence) is not used:
// HL7 defines it for antimicrobial susceptibility only. When no assessment was
// made at all, interpretation is simply absent.
ValueSet: SelfReportedInterpretationVS
Id: self-reported-interpretation-vs
Title: "SelfReportedInterpretation ValueSet"
Description: "Assessments the registry can record against self-reported readings and the figures aggregated from them, drawn from the HL7 ObservationInterpretation code system: critical high, significantly high, high, normal, low, significantly low and critical low, plus indeterminate for data that is not interpreted."
* ^url = "http://fhir.qualityregistry.org/ValueSet/self-reported-interpretation-vs"
* ^status = #active
* ^experimental = false
* include ObservationInterpretationCS#HH "Critical high"
* include ObservationInterpretationCS#HU "Significantly high"
* include ObservationInterpretationCS#H "High"
* include ObservationInterpretationCS#N "Normal"
* include ObservationInterpretationCS#L "Low"
* include ObservationInterpretationCS#LU "Significantly low"
* include ObservationInterpretationCS#LL "Critical low"
* include ObservationInterpretationCS#IND "Indeterminate"
