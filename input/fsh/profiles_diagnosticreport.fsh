// -----------------------------------------------------------------------------
// DiagnosticReport profiles
// -----------------------------------------------------------------------------

Profile: StrokeImagingDiagnosticReportProfile
Parent: DiagnosticReport
Id: stroke-imaging-diagnostic-report-profile
Title: "Stroke Imaging DiagnosticReport Profile"
Description: "DiagnosticReport profile for brain, carotid and follow-up imaging reports in the stroke pathway."
* ^url = "http://qualityregistry.org/StructureDefinition/stroke-imaging-diagnostic-report-profile"
* insert RESQProfileMetadata
* ^purpose = "Aggregates imaging observations and coded conclusions so imaging evidence can be referenced from procedures and clinical findings."
* insert RESQDiagnosticReportCore
* code from ImagingTypeVS (extensible)
* result 0..* MS
* result only Reference(Observation)
* result ^short = "Imaging result observations"
* conclusionCode 0..* MS
* conclusionCode from SpecificFindingVS (extensible)
* conclusionCode ^short = "Coded imaging conclusion"

Profile: MechanicalThrombectomyDiagnosticReportProfile
Parent: DiagnosticReport
Id: mechanical-thrombectomy-diagnostic-report-profile
Title: "Mechanical Thrombectomy DiagnosticReport Profile"
Description: "DiagnosticReport profile for thrombectomy outcome, especially mTICI reperfusion results."
* ^url = "http://qualityregistry.org/StructureDefinition/mechanical-thrombectomy-diagnostic-report-profile"
* insert RESQProfileMetadata
* ^purpose = "Collects procedure outcome observations after mechanical thrombectomy."
* insert RESQDiagnosticReportCore
* code from PerforationProceduresVS (extensible)
* result 1..* MS
* result only Reference(SpecificFindingObservationProfile)
* result ^short = "Thrombectomy outcome observation such as mTICI"
