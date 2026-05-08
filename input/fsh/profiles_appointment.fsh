// -----------------------------------------------------------------------------
// Appointment profiles
// -----------------------------------------------------------------------------

Profile: FollowUpAppointmentProfile
Parent: Appointment
Id: follow-up-appointment-profile
Title: "Three-Month Follow-up Appointment Profile"
Description: "Appointment profile for planned or recorded three-month neurology follow-up after the index stroke episode."
* ^url = "http://tecnomod-um.org/StructureDefinition/follow-up-appointment-profile"
* insert RESQProfileMetadata
* ^purpose = "Documents whether a structured three-month follow-up appointment is part of the stroke pathway."
* status 1..1 MS
* status ^short = "Appointment status"
* participant 1..* MS
* participant ^short = "Appointment participants"
* participant.actor 1..1 MS
* participant.actor only Reference(RESQPatientProfile)
* participant.actor ^short = "Patient participant"
* participant.status 1..1 MS
* participant.status ^short = "Patient participation status"
* specialty 1..* MS
* specialty from LocationsVS (extensible)
* specialty ^short = "Follow-up specialty or service"
