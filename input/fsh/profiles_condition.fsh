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
* obeys ischemic-etiology-only-for-ischemic-stroke
* obeys hemorrhagic-bleeding-reason-only-for-hemorrhagic-stroke
* obeys wakeup-stroke-true-should-have-onset
* obeys tia-should-have-evidence
* obeys mimic-diagnosis-should-not-have-stroke-specific-extensions

* category 1..* MS
* category = ConditionCategoryCS#encounter-diagnosis
* category ^short = "Encounter diagnosis"

* clinicalStatus 1..1 MS
* clinicalStatus = ConditionClinicalCS#active
* clinicalStatus ^short = "Active index diagnosis"

* verificationStatus 0..1 MS
* verificationStatus from http://hl7.org/fhir/ValueSet/condition-ver-status (required)
* verificationStatus ^short = "Verification state of diagnosis"

* code 1..1 MS
* code from StrokeDiagnosisCodeVS (extensible)
* code ^short = "Final diagnosis code for the stroke episode, including stroke mimics"

* bodySite 0..* MS
* bodySite from BodySitesVS (extensible)
* bodySite ^short = "Anatomical site of stroke involvement"

* evidence 0..* MS
* evidence ^short = "Diagnostic evidence supporting the stroke diagnosis"

* onset[x] 0..1 MS
* onset[x] only dateTime
* onset[x] ^short = "Stroke onset or last-known-well date/time"

* extension contains IschemicStrokeEtiologyExt named ischemicStrokeEtiology 0..1 MS
  and HemorrhagicStrokeBleedingReasonExt named hemorrhagicStrokeBleedingReason 0..* MS
  and WakeupStrokeExt named wakeupStroke 1..1 MS
* extension[ischemicStrokeEtiology] ^short = "Known ischemic stroke etiology"
* extension[hemorrhagicStrokeBleedingReason] ^short = "Known hemorrhagic bleeding reason"
* extension[wakeupStroke] ^short = "Wake-up stroke indicator"

Invariant: ischemic-etiology-only-for-ischemic-stroke
Description: "Ischemic stroke etiology extension should only be present when the diagnosis code is ischemic stroke."
Severity: #error
Expression: "extension.where(url = 'http://tecnomod-um.org/StructureDefinition/ischemic-stroke-etiology-ext').exists().not() or code.coding.where(system = 'http://snomed.info/sct' and code = '422504002').exists()"

Invariant: hemorrhagic-bleeding-reason-only-for-hemorrhagic-stroke
Description: "Hemorrhagic bleeding reason extension should only be present when the diagnosis code is hemorrhagic stroke or subarachnoid hemorrhage."
Severity: #error
Expression: "extension.where(url = 'http://tecnomod-um.org/StructureDefinition/hemorrhagic-stroke-bleeding-reason-ext').exists().not() or code.coding.where(system = 'http://snomed.info/sct' and (code = '274100004' or code = '21454007')).exists()"

Invariant: tia-should-have-evidence
Description: "If the diagnosis is transient ischemic attack, diagnostic evidence should preferably reference the observed symptoms."
Severity: #warning
Expression: "code.coding.where(system = 'http://snomed.info/sct' and code = '266257000').exists().not() or evidence.exists()"

Invariant: wakeup-stroke-true-should-have-onset
Description: "If wake-up stroke is true, onsetDateTime should be populated with the last-known-well or sleep timestamp."
Severity: #warning
Expression: "extension.where(url = 'http://tecnomod-um.org/StructureDefinition/wakeup-stroke-ext').value.ofType(boolean) != true or onset.exists()"

Invariant: mimic-diagnosis-should-not-have-stroke-specific-extensions
Description: "If the diagnosis code belongs to MimicsDiagnosisVS, stroke-specific etiology or hemorrhagic bleeding reason extensions should not be present."
Severity: #error
Expression: "code.memberOf('http://tecnomod-um.org/ValueSet/mimics-diagnosis-vs').not() or (extension.where(url = 'http://tecnomod-um.org/StructureDefinition/ischemic-stroke-etiology-ext').exists().not() and extension.where(url = 'http://tecnomod-um.org/StructureDefinition/hemorrhagic-stroke-bleeding-reason-ext').exists().not())"




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
