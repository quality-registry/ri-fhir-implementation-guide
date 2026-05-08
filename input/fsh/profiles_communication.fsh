// -----------------------------------------------------------------------------
// Communication profiles
// -----------------------------------------------------------------------------

Profile: ThreeMonthCommunicationProfile
Parent: Communication
Id: three-month-communication-profile
Title: "Three-Month Contact Communication Profile"
Description: "Communication profile for recording contact with the patient or caregiver at approximately three months after stroke."
* ^url = "http://tecnomod-um.org/StructureDefinition/three-month-communication-profile"
* insert RESQProfileMetadata
* ^purpose = "Captures follow-up contact status and contact modality for registry outcomes collected outside the acute encounter."
* status 1..1 MS
* status ^short = "Communication status"
* subject 0..1 MS
* subject only Reference(RESQPatientProfile)
* subject ^short = "Patient contacted at follow-up"
* encounter 0..1 MS
* encounter only Reference(StrokeEncounterProfile)
* encounter ^short = "Index stroke encounter associated with the contact"
* medium 0..* MS
* medium from ThreeMonthContactModeVS (extensible)
* medium ^short = "Follow-up contact mode"
* sent 0..1 MS
* sent ^short = "Date/time contact was sent or performed"
