// -----------------------------------------------------------------------------
// Condition profiles
// -----------------------------------------------------------------------------

Profile: StrokeDiagnosisConditionProfile
Parent: Condition
Id: stroke-diagnosis-condition-profile
Title: "Stroke Diagnosis Condition Profile"
Description: "Condition profile for the index stroke diagnosis. It captures stroke type, onset timing, body site, diagnostic evidence and stroke-specific classification extensions such as ischemic etiology, hemorrhagic bleeding reason and wake-up stroke status."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-diagnosis-condition-profile"
* insert RESQProfileMetadata
* ^purpose = "Represents the principal clinical diagnosis around which the registry episode is organized."
* insert RESQPatientSubject
* insert RESQEncounterContext
* clinicalStatus 1..1 MS
* clinicalStatus = ConditionClinicalCS#active
* clinicalStatus ^short = "Active index diagnosis"
* verificationStatus 0..1 MS
* verificationStatus from http://hl7.org/fhir/ValueSet/condition-ver-status (required)
* verificationStatus ^short = "Verification state of diagnosis"
* code 1..1 MS
* code from StrokeTypeVS (extensible)
* code ^short = "Stroke diagnosis type"
* bodySite 0..* MS
* bodySite from BodySitesVS (extensible)
* bodySite ^short = "Anatomical site of stroke involvement"
* evidence 0..* MS
* evidence ^short = "Diagnostic evidence supporting the stroke diagnosis"
* onset[x] 0..1 MS
* onset[x] only dateTime
* onset[x] ^short = "Stroke onset or last-known-well date/time"
* extension contains IschemicStrokeEtiologyExt named ischemicStrokeEtiology 0..1 MS
  and IschemicStrokeEtiologyKnownExt named ischemicStrokeEtiologyKnown 0..1 MS
  and HemorrhagicStrokeBleedingReasonExt named hemorrhagicStrokeBleedingReason 0..* MS
  and HemorrhagicStrokeBleedingReasonFoundExt named hemorrhagicStrokeBleedingReasonFound 0..1 MS
  and WakeupStrokeExt named wakeupStroke 1..1 MS
* extension[ischemicStrokeEtiology] ^short = "Known ischemic stroke etiology"
* extension[ischemicStrokeEtiologyKnown] ^short = "Known/unknown state for ischemic etiology"
* extension[hemorrhagicStrokeBleedingReason] ^short = "Known hemorrhagic bleeding reason"
* extension[hemorrhagicStrokeBleedingReasonFound] ^short = "Known/unknown state for bleeding reason"
* extension[wakeupStroke] ^short = "Wake-up stroke indicator"

Profile: StrokeRiskFactorConditionProfile
Parent: Condition
Id: stroke-risk-factor-condition-profile
Title: "Stroke Risk Factor Condition Profile"
Description: "Condition profile for pre-existing or episode-relevant risk factors captured in the RES-Q registry."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-risk-factor-condition-profile"
* insert RESQProfileMetadata
* ^purpose = "Represents comorbidities and clinical risk factors used in stroke quality measurement and outcome analysis."
* insert RESQPatientSubject
* insert RESQEncounterContext
* clinicalStatus 1..1 MS
* clinicalStatus from ClinicalStatusCodesVS (required)
* clinicalStatus ^short = "Clinical status of the risk factor"
* verificationStatus 0..1 MS
* verificationStatus ^short = "Verification status when available"
* code 1..1 MS
* code from RiskFactorVS (extensible)
* code ^short = "Stroke risk factor"

Profile: PostStrokeComplicationConditionProfile
Parent: Condition
Id: post-stroke-complication-condition-profile
Title: "Post-Stroke Complication Condition Profile"
Description: "Condition profile for complications occurring after the index stroke, including complications relevant to post-acute care and registry outcome tracking."
* ^url = "http://tecnomod-um.org/StructureDefinition/post-stroke-complication-condition-profile"
* insert RESQProfileMetadata
* ^purpose = "Records clinically meaningful post-stroke complications as conditions linked to the stroke encounter."
* insert RESQPatientSubject
* insert RESQEncounterContext
* clinicalStatus 1..1 MS
* clinicalStatus from ClinicalStatusCodesVS (required)
* clinicalStatus ^short = "Clinical status of the complication"
* code 1..1 MS
* code from PostStrokeComplicationsVS (extensible)
* code ^short = "Post-stroke complication"
