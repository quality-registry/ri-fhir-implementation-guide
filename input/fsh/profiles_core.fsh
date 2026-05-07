// -----------------------------------------------------------------------------
// Core administrative and structural profiles
// -----------------------------------------------------------------------------

Profile: RESQPatientProfile
Parent: Patient
Id: resq-patient-profile
Title: "RESQ Patient Profile"
Description: "Patient profile aligned with build_Patient(): identifier is required and sex/gender is captured with a SNOMED CT extension. Age is represented as an Observation in the ETL, not as a Patient extension."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-patient-profile"
* ^status = #active
* identifier 1..* MS
* extension contains GenderSnomedExt named genderSnomed 0..1 MS
* gender 0..0

Profile: StrokeRegistryOrganizationProfile
Parent: Organization
Id: stroke-registry-organization-profile
Title: "Stroke Registry Organization Profile"
Description: "Organization profile aligned with build_organization(): active=true, registry identifier and canonical hospital name."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-registry-organization-profile"
* ^status = #active
* active 1..1 MS
* active = true
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator[0].type = #value
* identifier ^slicing.discriminator[0].path = "system"
* identifier ^slicing.rules = #open
* identifier contains registry 1..1 MS
* identifier[registry].system 1..1 MS
* identifier[registry].system = StrokeRegistryIdSystem (exactly)
* identifier[registry].value 1..1 MS

Profile: StrokeEncounterProfile
Parent: Encounter
Id: stroke-encounter-profile
Title: "Stroke Encounter Profile"
Description: "Index stroke encounter profile aligned with build_stroke_encounter_profile()."
* ^url = "http://tecnomod-um.org/StructureDefinition/stroke-encounter-profile"
* ^status = #active
* status 1..1 MS
* status = #completed
* subject 1..1 MS
* subject only Reference(RESQPatientProfile)
* class 0..* MS
* admission 0..1 MS
* admission.admitSource 0..1 MS
* admission.admitSource from AdmissionPathwayVS (extensible)
* admission.dischargeDisposition 0..1 MS
* admission.dischargeDisposition from DischargeDestinationVS (extensible)
* location 0..* MS
* location.location only Reference(Location)
* extension contains FirstHospitalExt named firstHospital 1..1 MS
  and RequiredPostAcuteCareExt named requiredPostAcuteCare 1..1 MS
  and EmsPrenotificationExt named emsPrenotification 1..1 MS
  and DischargeDepartmentServiceExt named dischargeDepartmentService 0..1 MS

Profile: RESQLocationProfile
Parent: Location
Id: resq-location-profile
Title: "RESQ Location Profile"
Description: "Generic coded location profile aligned with build_location()."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-location-profile"
* ^status = #active
* type 1..* MS
* type from LocationsVS (extensible)

Profile: HospitalizedLocationProfile
Parent: Location
Id: hospitalized-location-profile
Title: "Hospitalized Location Profile"
Description: "Hospitalized location profile aligned with build_hospitalized_location(): Location.type stores admission department and extension stores care intensity."
* ^url = "http://tecnomod-um.org/StructureDefinition/hospitalized-location-profile"
* ^status = #active
* type 1..* MS
* type from AdmissionDepartmentVS (extensible)
* extension contains InitialCareIntensityExt named initialCareIntensity 1..1 MS

Profile: RESQBodyStructureProfile
Parent: BodyStructure
Id: resq-body-structure-profile
Title: "RESQ BodyStructure Profile"
Description: "BodyStructure profile for occluded arteries or anatomical structures, aligned with build_bodyStructure()."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-body-structure-profile"
* ^status = #active
* patient 1..1 MS
* patient only Reference(RESQPatientProfile)
* includedStructure 1..* MS
* includedStructure.structure 1..1 MS
* includedStructure.structure from BodySitesVS (extensible)
* includedStructure.laterality 0..1 MS
* includedStructure.laterality from LateralityVS (extensible)

Profile: RESQPractitionerRoleProfile
Parent: PractitionerRole
Id: resq-practitioner-role-profile
Title: "RESQ PractitionerRole Profile"
Description: "PractitionerRole profile for recording performer type in swallowing screening and related procedures."
* ^url = "http://tecnomod-um.org/StructureDefinition/resq-practitioner-role-profile"
* ^status = #active
* code 1..* MS
* code from ScreeningPerformerVS (extensible)

Profile: FollowUpAppointmentProfile
Parent: Appointment
Id: follow-up-appointment-profile
Title: "Three-Month Follow-up Appointment Profile"
Description: "Follow-up neurology appointment profile aligned with build_follow_up_appointment()."
* ^url = "http://tecnomod-um.org/StructureDefinition/follow-up-appointment-profile"
* ^status = #active
* status 1..1 MS
* participant 1..* MS
* participant.actor 1..1 MS
* participant.actor only Reference(RESQPatientProfile)
* participant.status 1..1 MS
* specialty 1..* MS
* specialty from LocationsVS (extensible)

Profile: ThreeMonthCommunicationProfile
Parent: Communication
Id: three-month-communication-profile
Title: "Three-Month Contact Communication Profile"
Description: "Communication profile for three-month follow-up contact, aligned with build_three_m_contact()."
* ^url = "http://tecnomod-um.org/StructureDefinition/three-month-communication-profile"
* ^status = #active
* status 1..1 MS
* subject 0..1 MS
* subject only Reference(RESQPatientProfile)
* encounter 0..1 MS
* encounter only Reference(StrokeEncounterProfile)
* medium 0..* MS
* medium from ThreeMonthContactModeVS (extensible)
* sent 0..1 MS
