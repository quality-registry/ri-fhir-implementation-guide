// -----------------------------------------------------------------------------
// Procedure profiles
// -----------------------------------------------------------------------------

Profile: StrokeImagingProcedureProfile
Parent: Procedure
Id: stroke-imaging-procedure-profile
Title: "Stroke Imaging Procedure Profile"
Description: "Procedure profile for brain imaging performed in the stroke pathway, with optional report linkage and timing context."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-imaging-procedure-profile"
* insert RESQProfileMetadata
* ^purpose = "Represents acute or follow-up neuroimaging procedures used to diagnose, treat or monitor stroke."
* status 1..1 MS
* status ^short = "Imaging procedure status"
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* insert RESQPatientSubject
* insert RESQEncounterContext
* code 0..1 MS
* code from ImagingTypeVS (extensible)
* code ^short = "Brain imaging type"
* category 0..*
* category = SCT#103693007 "Diagnostic procedure"
* occurrence[x] 0..1 MS
* occurrence[x] only dateTime
* occurrence[x] ^short = "Imaging date/time"
* report 0..* MS
* report only Reference(StrokeImagingDiagnosticReportProfile)
* report ^short = "Imaging diagnostic report"
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS

Profile: StrokeCarotidImagingProcedureProfile
Parent: Procedure
Id: stroke-carotid-imaging-procedure-profile
Title: "Stroke Carotid Imaging Procedure Profile"
Description: "Procedure profile for carotid imaging used in post-stroke assessment."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* insert RESQProfileMetadata
* status 1..1 MS
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* insert RESQPatientSubject
* insert RESQEncounterContext
* code 1..1 MS
* code from ImagingTypeVS (extensible)
* code ^short = "Carotid imaging type"
* report 0..* MS
* report ^short = "Carotid imaging report"
* extension contains PostAcuteCareRequiredExt named postAcuteCareRequired 1..1 MS

Profile: StrokeCarotidEndarterectomyProcedureProfile
Parent: Procedure
Id: stroke-carotid-endarterectomy-procedure-profile
Title: "Stroke Carotid Endarterectomy Procedure Profile"
Description: "Procedure profile for carotid endarterectomy and its timing window in the RES-Q pathway."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* insert RESQProfileMetadata
* status 1..1 MS
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* insert RESQPatientSubject
* insert RESQEncounterContext
* code 1..1 MS
* code from PerforationProceduresVS (extensible)
* code ^short = "Carotid endarterectomy procedure"
* occurrence[x] 0..1 MS
* occurrence[x] only Range
* occurrence[x] ^short = "Timing range for procedure"
* report 0..* MS
* extension contains PostAcuteCareRequiredExt named postAcuteCareRequired 1..1 MS

Profile: StrokeMechanicalProcedureProfile
Parent: Procedure
Id: stroke-mechanical-procedure-profile
Title: "Stroke Reperfusion Procedure Profile"
Description: "Procedure profile for acute reperfusion interventions, including thrombolysis and mechanical thrombectomy. It supports reason, not-done reason, location, occurrence, complications and timing context."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-mechanical-procedure-profile"
* insert RESQProfileMetadata
* ^purpose = "Captures key acute reperfusion procedures and non-performance reasons for quality metrics."
* status 1..1 MS
* insert RESQPatientSubject
* insert RESQEncounterContext
* reason 0..* MS
* reason only CodeableReference(StrokeDiagnosisConditionProfile)
* reason ^short = "Index stroke diagnosis prompting reperfusion"
* code 1..1 MS
* code from PerforationProceduresVS (extensible)
* code ^short = "Reperfusion procedure"
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* statusReason ^short = "Reason procedure was not done or status rationale"
* location 0..1 MS
* location ^short = "Location where procedure occurred"
* occurrence[x] 0..1 MS
* occurrence[x] only Period or dateTime
* occurrence[x] ^short = "Procedure date/time or interval"
* complication 0..* MS
* complication from ThrombectomyComplicationsVS (extensible)
* complication ^short = "Procedure complication"
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS
  and PostAcuteCareRequiredExt named postAcuteCareRequired 0..1 MS

Profile: StrokeSwallowProcedureProfile
Parent: Procedure
Id: stroke-swallow-procedure-profile
Title: "Stroke Swallowing Screening Procedure Profile"
Description: "Procedure profile for swallowing screening, including screening type, not-done reason, performer role and timing context."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-swallow-procedure-profile"
* insert RESQProfileMetadata
* status 1..1 MS
* insert RESQPatientSubject
* insert RESQEncounterContext
* obeys stroke-swallow-completed-requires-post-acute-care
* obeys stroke-swallow-not-done-requires-status-reason
* code 0..1 MS
* code from SwallowingScreeningTypeVS (extensible)
* code ^short = "Swallowing screening type"
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* statusReason ^short = "Reason screening was not done"
* performer 0..* MS
* performer ^short = "Screening performer"
* performer.actor only Reference(RESQPractitionerRoleProfile)
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS
  and PostAcuteCareRequiredExt named postAcuteCareRequired 0..1 MS

Invariant: stroke-swallow-completed-requires-post-acute-care
Description: "If the swallowing screening procedure is completed, post-acute care required extension SHALL be present."
Severity: #error
Expression: "status != 'completed' or extension.where(url = 'http://tecnomod-um.org/StructureDefinition/post-acute-care-required-ext').exists()"

Invariant: stroke-swallow-not-done-requires-status-reason
Description: "If the swallowing screening procedure was not done, statusReason SHALL be present."
Severity: #error
Expression: "status != 'not-done' or statusReason.exists()"

Profile: StrokeVTEProcedureProfile
Parent: Procedure
Id: stroke-vte-procedure-profile
Title: "Stroke VTE Prophylaxis Procedure Profile"
Description: "Procedure profile for venous thromboembolism prophylaxis used in the stroke pathway."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-vte-procedure-profile"
* insert RESQProfileMetadata
* status 1..1 MS
* insert RESQPatientSubject
* insert RESQEncounterContext
* code 1..1 MS
* code from VteProceduresVS (extensible)
* code ^short = "VTE prophylaxis procedure"

Profile: StrokeTreatmentProcedureProfile
Parent: Procedure
Id: stroke-treatment-procedure-profile
Title: "Stroke Treatment Procedure Profile"
Description: "Generic treatment and rehabilitation profile for ICH, SAH, CVT, craniectomy, therapy, smoking cessation and shunt procedures not given a dedicated meta.profile in the Python builders."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-treatment-procedure-profile"
* insert RESQProfileMetadata
* status 1..1 MS
* insert RESQPatientSubject
* insert RESQEncounterContext
* reason 0..* MS
* reason ^short = "Clinical reason for treatment"
* code 1..1 MS
* code from StrokeTreatmentProcedureVS (extensible)
* code ^short = "Treatment, rehabilitation or neurosurgical procedure"
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* occurrence[x] 0..1 MS
* occurrence[x] only dateTime or Period or Range
* occurrence[x] ^short = "Procedure date/time, interval or timing range"
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS

Invariant: stroke-treatment-poststroke-timing-required
Description: "If Procedure.code belongs to PostStrokeProceduresVS, procedureTimingContext must be present with AssessmentContextCS#post-stroke."
Severity: #error
Expression: "code.memberOf('http://tecnomod-um.org/ValueSet/post-stroke-procedures-vs').not() or extension.where(url = 'http://tecnomod-um.org/StructureDefinition/procedure-timing-context-ext').value.ofType(CodeableConcept).coding.where(system = 'http://tecnomod-um.org/CodeSystem/assessment-context-cs' and code = 'post-stroke').exists()"