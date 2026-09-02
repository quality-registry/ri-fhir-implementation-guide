// -----------------------------------------------------------------------------
// Encounter profiles
// -----------------------------------------------------------------------------

Profile: StrokeEncounterProfile
Parent: Encounter
Id: stroke-encounter-profile
Title: "Stroke Encounter Profile"
Description: "Index encounter for an acute stroke episode in the RES-Q registry. It records the patient, completed encounter state, admission and discharge pathway information, hospital locations, first-hospital status, EMS prenotification and post-acute-care applicability."
* ^url = "http://qualityregistry.org/StructureDefinition/stroke-encounter-profile"
* insert RESQProfileMetadata
* ^purpose = "Acts as the central clinical context for diagnosis, observations, procedures, medication administrations and follow-up resources created for one stroke episode."
* status 1..1 MS
* status = #completed
* status ^short = "Completed stroke episode encounter"
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* subject ^short = "Patient with the index stroke episode"
* class 0..* MS
* class ^short = "Encounter class or care setting"
* admission 0..1 MS
* admission ^short = "Admission and discharge pathway details"
* admission.admitSource 0..1 MS
* admission.admitSource from AdmissionPathwayVS (extensible)
* admission.admitSource ^short = "Pathway or source before hospital admission"
* admission.dischargeDisposition 0..1 MS
* admission.dischargeDisposition from DischargeDestinationVS (extensible)
* admission.dischargeDisposition ^short = "Destination or disposition after discharge"
* location 0..* MS
* location ^short = "Locations used during the stroke pathway"
* location.location only Reference(Location)
* extension contains FirstHospitalExt named firstHospital 1..1 MS
  and RequiredPostAcuteCareExt named requiredPostAcuteCare 1..1 MS
  and EmsPrenotificationExt named emsPrenotification 1..1 MS
  and DischargeFacilityTypeExt named dischargeFacilityType 0..1 MS
  and DischargeDepartmentServiceExt named dischargeDepartmentService 0..1 MS

* extension[firstHospital] ^short = "Whether this was the first hospital attended"
* extension[requiredPostAcuteCare] ^short = "Whether post-acute care was required or applicable"
* extension[emsPrenotification] ^short = "Whether EMS prenotified the receiving hospital"
* extension[dischargeFacilityType] ^short = "Type of facility or transfer destination after discharge"
* extension[dischargeDepartmentService] ^short = "Discharge department, service or facility type"
