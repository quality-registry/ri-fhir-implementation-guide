// -----------------------------------------------------------------------------
// Procedure and DiagnosticReport profiles
// -----------------------------------------------------------------------------

Profile: StrokeImagingProcedureProfile
Parent: Procedure
Id: stroke-imaging-procedure-profile
Title: "Stroke Imaging Procedure Profile"
Description: "Brain imaging Procedure aligned with build_imaging_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-imaging-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 0..1 MS
* code from ImagingTypeVS (extensible)
* category 0..* MS
* category = ObservationCategoryCS#imaging
* occurrence[x] 0..1 MS
* occurrence[x] only dateTime
* report 0..* MS
* report only Reference(StrokeImagingDiagnosticReportProfile)
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS

Profile: StrokeCarotidImagingProcedureProfile
Parent: Procedure
Id: stroke-carotid-imaging-procedure-profile
Title: "Stroke Carotid Imaging Procedure Profile"
Description: "Carotid imaging Procedure aligned with build_carotid_imaging_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-carotid-imaging-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS
* code from ImagingTypeVS (extensible)
* report 0..* MS
* extension contains PostAcuteCareRequiredExt named postAcuteCareRequired 1..1 MS

Profile: StrokeCarotidEndarterectomyProcedureProfile
Parent: Procedure
Id: stroke-carotid-endarterectomy-procedure-profile
Title: "Stroke Carotid Endarterectomy Procedure Profile"
Description: "Carotid endarterectomy Procedure aligned with build_endarterectomy_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-carotid-endarterectomy-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS
* code from PerforationProceduresVS (extensible)
* occurrence[x] 0..1 MS
* occurrence[x] only Range
* report 0..* MS
* extension contains PostAcuteCareRequiredExt named postAcuteCareRequired 1..1 MS

Profile: StrokeMechanicalProcedureProfile
Parent: Procedure
Id: stroke-mechanical-procedure-profile
Title: "Stroke Reperfusion Procedure Profile"
Description: "Thrombolysis and mechanical thrombectomy Procedure profile aligned with build_thrombolysis_procedure() and build_thrombectomy_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-mechanical-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* reason 0..* MS
* reason only CodeableReference(StrokeDiagnosisConditionProfile)
* code 1..1 MS
* code from PerforationProceduresVS (extensible)
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* location 0..1 MS
* occurrence[x] 0..1 MS
* occurrence[x] only Period or dateTime
* complication 0..* MS
* complication from ThrombectomyComplicationsVS (extensible)
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS
  and PostAcuteCareRequiredExt named postAcuteCareRequired 0..1 MS

Profile: StrokeSwallowProcedureProfile
Parent: Procedure
Id: stroke-swallow-procedure-profile
Title: "Stroke Swallowing Screening Procedure Profile"
Description: "Swallowing screening Procedure aligned with build_swallowing_screening_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-swallow-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 0..1 MS
* code from SwallowingScreeningTypeVS (extensible)
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* performer 0..* MS
* performer.actor only Reference(RESQPractitionerRoleProfile)
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS
  and PostAcuteCareRequiredExt named postAcuteCareRequired 1..1 MS

Profile: StrokeVTEProcedureProfile
Parent: Procedure
Id: stroke-vte-procedure-profile
Title: "Stroke VTE Prophylaxis Procedure Profile"
Description: "VTE prophylaxis Procedure profile aligned with build_vte_procedure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-vte-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS
* code from VteProceduresVS (extensible)

Profile: StrokeTreatmentProcedureProfile
Parent: Procedure
Id: stroke-treatment-procedure-profile
Title: "Stroke Treatment Procedure Profile"
Description: "Generic treatment/rehabilitation profile for ICH, SAH, CVT, craniectomy, therapy, smoking cessation and shunt procedures not given a dedicated meta.profile in the Python builders."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-treatment-procedure-profile"
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* reason 0..* MS
* code 1..1 MS
* statusReason 0..1 MS
* statusReason from ProcedureNotDoneReasonVS (extensible)
* occurrence[x] 0..1 MS
* occurrence[x] only dateTime or Period or Range
* extension contains ProcedureTimingContextExt named procedureTimingContext 0..1 MS

Profile: StrokeImagingDiagnosticReportProfile
Parent: DiagnosticReport
Id: stroke-imaging-diagnostic-report-profile
Title: "Stroke Imaging DiagnosticReport Profile"
Description: "Imaging DiagnosticReport profile aligned with build_imaging_diagnostic_report(), build_carotid_arteries_imaging_diagnostic_report(), build_ct_mr_after_ivt_diagnostic_report() and build_follow_up_ct_mr_diagnostic_report()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* status 1..1 MS
* status = #final
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS
* code from ImagingTypeVS (extensible)
* result 0..* MS
* result only Reference(Observation)
* conclusionCode 0..* MS
* conclusionCode from SpecificFindingVS (extensible)

Profile: MechanicalThrombectomyDiagnosticReportProfile
Parent: DiagnosticReport
Id: mechanical-thrombectomy-diagnostic-report-profile
Title: "Mechanical Thrombectomy DiagnosticReport Profile"
Description: "DiagnosticReport profile for thrombectomy outcome, especially mTICI score."
* ^url = "http://tecnomod-um.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* status 1..1 MS
* status = #final
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 1..1 MS
* encounter only Reference(StrokeEncounterProfile)
* code 1..1 MS
* code from PerforationProceduresVS (extensible)
* result 1..* MS
* result only Reference(SpecificFindingObservationProfile)
