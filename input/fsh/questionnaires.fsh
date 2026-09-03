// ----------------------------------------------------------------------------
// RES-Q patient-reported questionnaires
//
// Definitional Questionnaire instances for the four questionnaires served by the
// RES-Q questionnaire service. Item texts, item codes, answer options, answer
// weights and skip logic are taken from the service data migration
// apps/questionnaire_app/migrations/migrations_data/m0002_questionnaires.py.
//
// Answer weights use the R5 itemWeight extension, whose context is
// Questionnaire.item.answerOption. The mRS items are boolean and therefore carry no
// answerOption at all -- FHIR does not allow a boolean answer option -- so the mRS
// scoring rule is stated in that questionnaire description instead.
//
// Every item is required and non-repeating: the service data model has no repeats
// field and no nested items. Note that required = true on every item contradicts the
// skip support the service implements via the questionnaire-skipped-item extension;
// the flag is reproduced as the source states it.
//
// KNOWN TERMINOLOGY DEFECTS IN THE SOURCE DATA. Both were found by validating these
// artifacts against SNOMED CT. They are problems in the questionnaire service data, not
// authoring mistakes here, and the service must be updated for either to be resolved at
// source. Both are corrected in this guide: a Coding.display that is not a designation
// of its code, and a code that does not exist, are each unresolvable by a consumer.
//
// 1. CORRECTED HERE. Eight answer codes carry a registry label that is not a valid
//    designation of the SNOMED CT concept. This guide publishes a valid designation
//    instead; where SNOMED CT offers several, the one closest in meaning to the registry
//    label is used. The registry labels are recorded here because they are what the
//    questionnaire service sends today and what patients are shown on screen, and
//    because the PHQ-9 and SF-NEADL answer wording is fixed by the instruments.
//    Code -> label the service sends -> display published here:
//      260353006  "Not at all"                     -> "Nothing at all"
//      5878004    "Several days"                   -> "Low frequency"
//      255218000  "More than half the days"        -> "Mid-frequency"
//      27732004   "Nearly every day"               -> "High frequency"
//      371151008  "Unable to do"                   -> "Unable"
//      371154000  "Needs help"                     -> "Dependent"
//      371157007  "Independent with difficulty"    -> "Able with difficulty"
//      371153006  "Independent without difficulty" -> "Independently able"
//
//    Note the consequence: a renderer driving a patient-facing form from these
//    Questionnaire instances will show the SNOMED CT wording, not the instrument
//    wording. If the instrument wording has to reach the patient, the answers need
//    codes whose designations carry it -- either the LOINC PHQ-9 answer list, or local
//    CodeSystems in the style of SfSisAnswersCS in terminology_questionnaires.fsh.
//
// 2. CORRECTED HERE. The item code on phq9_q4 is SNOMED CT 250436004 "Fatigue
//    (finding)" in the source, which is not a valid code in the SNOMED CT
//    International Edition at all. It is published here as 84229001 "Fatigue
//    (finding)", the valid concept for the same meaning. This is the one place where
//    these Questionnaire instances deliberately depart from the service data.
//
// All other item codes and answer codes verify cleanly.
//
// Each instance carries two identifiers: the service resource_id used to address
// the questionnaire over the REST API, and the legacy qualityregistry.org
// canonical the service publishes today, retained for traceability while the
// service is migrated onto the URLs published here.
// ----------------------------------------------------------------------------

Instance: MrsQuestionnaire
InstanceOf: PatientReportedOutcomeQuestionnaires
Usage: #definition
Title: "mRS Questionnaire"
Description: "Modified Rankin Scale Questionnaire. A five-item decision tree of yes/no questions. The mRS score is the outcome of the path taken through the enableWhen conditions, not a sum of answer weights, so it is stated here rather than as itemWeight on answer options (FHIR boolean items have no answerOption to weight): mrs_q2 no gives 2; mrs_q3 yes gives 0 and no gives 1; mrs_q4 yes gives 3; mrs_q5 yes gives 4 and no gives 5."
* id = "mrs-questionnaire"
* url = "http://fhir.qualityregistry.org/Questionnaire/mrs-questionnaire"
* identifier[0].system = "http://fhir.qualityregistry.org/identifier/questionnaire-resource-id"
* identifier[0].value = "mrs_001"
* identifier[1].system = "urn:ietf:rfc:3986"
* identifier[1].value = "https://qualityregistry.org/questionnaires/mrs"
* version = "1.0.0"
* name = "MRSQuestionnaire"
* status = #active
* experimental = false
* date = "2025-01-03"
* publisher = "Stroke Quality Registry"
* code[0] = SCT#840352000 "Modified Rankin Scale"
// mrs_q1
* item[0].linkId = "mrs_q1"
* item[0].code = SCT#443285000 "Does perform all activities of daily living without assistance (finding)"
* item[0].text = "If you had to, could you live alone without any help from another person?"
* item[0].type = #boolean
* item[0].required = true
* item[0].repeats = false
// mrs_q2
* item[1].linkId = "mrs_q2"
* item[1].code = SCT#55221000087102 "Loss of functional autonomy in activities of daily living (finding)"
* item[1].text = "Can you do everything that you were doing right before your stroke, even if slower and not as much?"
* item[1].type = #boolean
* item[1].required = true
* item[1].repeats = false
* item[1].enableBehavior = #all
* item[1].enableWhen[0].question = "mrs_q1"
* item[1].enableWhen[0].operator = #"="
* item[1].enableWhen[0].answerBoolean = true
// score: false -> 2
// mrs_q3
* item[2].linkId = "mrs_q3"
* item[2].code = SCT#1131000119105 "Sequela of cerebrovascular accident (disorder)"
* item[2].text = "Are you completely back to the way you were right before your stroke?"
* item[2].type = #boolean
* item[2].required = true
* item[2].repeats = false
* item[2].enableBehavior = #all
* item[2].enableWhen[0].question = "mrs_q2"
* item[2].enableWhen[0].operator = #"="
* item[2].enableWhen[0].answerBoolean = true
// score: true -> 0, false -> 1
// mrs_q4
* item[3].linkId = "mrs_q4"
* item[3].code = SCT#282153000 "Difficulty walking on the flat (finding)"
* item[3].text = "Can you walk from one room to another without help from another person?"
* item[3].type = #boolean
* item[3].required = true
* item[3].repeats = false
* item[3].enableBehavior = #all
* item[3].enableWhen[0].question = "mrs_q1"
* item[3].enableWhen[0].operator = #"="
* item[3].enableWhen[0].answerBoolean = false
// score: true -> 3
// mrs_q5
* item[4].linkId = "mrs_q5"
* item[4].code = SCT#282930002 "Able to move from lying to sitting (finding)"
* item[4].text = "Can you sit up in bed without any help?"
* item[4].type = #boolean
* item[4].required = true
* item[4].repeats = false
* item[4].enableBehavior = #all
* item[4].enableWhen[0].question = "mrs_q4"
* item[4].enableWhen[0].operator = #"="
* item[4].enableWhen[0].answerBoolean = false
// score: true -> 4, false -> 5

Instance: Phq9Questionnaire
InstanceOf: PatientReportedOutcomeQuestionnaires
Usage: #definition
Title: "PHQ-9 Questionnaire"
Description: "Patient Health Questionnaire-9. Nine items, each scored 0-3 over the same four SNOMED CT frequency answers, giving a total of 0-27."
* id = "phq9-questionnaire"
* url = "http://fhir.qualityregistry.org/Questionnaire/phq9-questionnaire"
* identifier[0].system = "http://fhir.qualityregistry.org/identifier/questionnaire-resource-id"
* identifier[0].value = "phq9_001"
* identifier[1].system = "urn:ietf:rfc:3986"
* identifier[1].value = "https://qualityregistry.org/questionnaires/phq-9"
* version = "1.0.0"
* name = "PHQ9Questionnaire"
* status = #active
* experimental = false
* date = "2026-01-03"
* publisher = "Stroke Quality Registry"
* code[0] = SCT#715252007 "Depression screening using Patient Health Questionnaire Nine Item score (procedure)"
// phq9_q1
* item[0].linkId = "phq9_q1"
* item[0].code = SCT#247753000 "Loss of interest (finding)"
* item[0].text = "Over the last 2 weeks, little interest or pleasure in doing things"
* item[0].type = #coding
* item[0].required = true
* item[0].repeats = false
* item[0].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[0].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[0].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[0].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[0].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[0].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[0].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[0].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q2
* item[1].linkId = "phq9_q2"
* item[1].code = SCT#307077003 "Feeling hopeless (finding)"
* item[1].text = "Over the last 2 weeks, feeling down, depressed, or hopeless"
* item[1].type = #coding
* item[1].required = true
* item[1].repeats = false
* item[1].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[1].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[1].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[1].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[1].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[1].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[1].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[1].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q3
* item[2].linkId = "phq9_q3"
* item[2].code = SCT#44186003 "Dyssomnia (disorder)"
* item[2].text = "Over the last 2 weeks, trouble falling or staying asleep, or sleeping too much"
* item[2].type = #coding
* item[2].required = true
* item[2].repeats = false
* item[2].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[2].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[2].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[2].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[2].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[2].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[2].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[2].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q4
* item[3].linkId = "phq9_q4"
* item[3].code = SCT#84229001 "Fatigue (finding)"
* item[3].text = "Over the last 2 weeks, feeling tired or having little energy"
* item[3].type = #coding
* item[3].required = true
* item[3].repeats = false
* item[3].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[3].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[3].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[3].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[3].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[3].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[3].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[3].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q5
* item[4].linkId = "phq9_q5"
* item[4].code = SCT#72405004 "Increased appetite (finding)"
* item[4].text = "Over the last 2 weeks, poor appetite or overeating"
* item[4].type = #coding
* item[4].required = true
* item[4].repeats = false
* item[4].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[4].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[4].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[4].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[4].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[4].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[4].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[4].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q6
* item[5].linkId = "phq9_q6"
* item[5].code = SCT#286647002 "Low self-esteem (finding)"
* item[5].text = "Over the last 2 weeks, feeling bad about yourself-or that you are a failure or have let yourself or your family down"
* item[5].type = #coding
* item[5].required = true
* item[5].repeats = false
* item[5].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[5].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[5].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[5].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[5].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[5].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[5].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[5].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q7
* item[6].linkId = "phq9_q7"
* item[6].code = SCT#26329005 "Poor concentration (finding)"
* item[6].text = "Over the last 2 weeks, trouble concentrating on things, such as reading the newspaper or watching television"
* item[6].type = #coding
* item[6].required = true
* item[6].repeats = false
* item[6].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[6].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[6].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[6].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[6].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[6].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[6].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[6].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q8
* item[7].linkId = "phq9_q8"
* item[7].code = SCT#247910009 "Fidgeting (finding)"
* item[7].text = "Over the last 2 weeks, moving or speaking so slowly that other people could have noticed. Or the opposite-being so fidgety or restless that you have been moving around a lot more than usual"
* item[7].type = #coding
* item[7].required = true
* item[7].repeats = false
* item[7].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[7].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[7].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[7].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[7].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[7].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[7].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[7].answerOption[3].extension[ItemWeight].valueDecimal = 3
// phq9_q9
* item[8].linkId = "phq9_q9"
* item[8].code = SCT#6471006 "Suicidal thoughts (finding)"
* item[8].text = "Over the last 2 weeks, thoughts that you would be better off dead, or of hurting yourself in some way"
* item[8].type = #coding
* item[8].required = true
* item[8].repeats = false
* item[8].answerOption[0].valueCoding = SCT#260353006 "Nothing at all"
* item[8].answerOption[0].extension[ItemWeight].valueDecimal = 0
* item[8].answerOption[1].valueCoding = SCT#5878004 "Low frequency"
* item[8].answerOption[1].extension[ItemWeight].valueDecimal = 1
* item[8].answerOption[2].valueCoding = SCT#255218000 "Mid-frequency"
* item[8].answerOption[2].extension[ItemWeight].valueDecimal = 2
* item[8].answerOption[3].valueCoding = SCT#27732004 "High frequency"
* item[8].answerOption[3].extension[ItemWeight].valueDecimal = 3

Instance: SfSisQuestionnaire
InstanceOf: PatientReportedOutcomeQuestionnaires
Usage: #definition
Title: "SF-SIS Questionnaire"
Description: "Short-form Stroke Impact Scale Questionnaire. Eight items, each scored 1-5. Note that the shared answer scale is worded as a difficulty scale (\"Could not do it at all\" to \"Not difficult at all\") while sfsis_q3 (\"how often did you feel...\") and sfsis_q8 (\"how much of the time...\") are frequency stems; this mismatch is present in the source instrument as operated by the registry and is reproduced here rather than silently reworded."
* id = "sf-sis-questionnaire"
* url = "http://fhir.qualityregistry.org/Questionnaire/sf-sis-questionnaire"
* identifier[0].system = "http://fhir.qualityregistry.org/identifier/questionnaire-resource-id"
* identifier[0].value = "sf-sis_001"
* identifier[1].system = "urn:ietf:rfc:3986"
* identifier[1].value = "https://qualityregistry.org/questionnaires/sf-sis"
* version = "1.0.0"
* name = "SFSISQuestionnaire"
* status = #active
* experimental = false
* date = "2026-03-05"
* publisher = "Stroke Quality Registry"
* code[0] = RESQQuestionnairesCS#sfsis "short-form Stroke Impact Scale"
// sfsis_q1
* item[0].linkId = "sfsis_q1"
* item[0].code = SupplementalQuestionsCS#sfsis_q1_custom "In the past week, how would you rate the strength of your leg that was most affected by your stroke?"
* item[0].text = "In the past week, how would you rate the strength of your leg that was most affected by your stroke?"
* item[0].type = #coding
* item[0].required = true
* item[0].repeats = false
* item[0].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[0].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[0].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[0].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[0].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[0].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[0].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[0].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[0].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[0].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q2
* item[1].linkId = "sfsis_q2"
* item[1].code = SCT#302760000 "Fast flow of thought (finding)"
* item[1].text = "In the past week, how difficult was it for you to think quickly?"
* item[1].type = #coding
* item[1].required = true
* item[1].repeats = false
* item[1].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[1].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[1].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[1].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[1].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[1].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[1].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[1].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[1].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[1].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q3
* item[2].linkId = "sfsis_q3"
* item[2].code = SCT#307077003 "Feeling hopeless (finding)"
* item[2].text = "In the past week, how often did you feel that you have nothing to look forward to?"
* item[2].type = #coding
* item[2].required = true
* item[2].repeats = false
* item[2].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[2].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[2].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[2].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[2].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[2].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[2].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[2].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[2].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[2].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q4
* item[3].linkId = "sfsis_q4"
* item[3].code = SCT#716484005 "Difficulty understanding verbal language (finding)"
* item[3].text = "In the past week, how difficult was it to understand what was being said to you in a conversation?"
* item[3].type = #coding
* item[3].required = true
* item[3].repeats = false
* item[3].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[3].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[3].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[3].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[3].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[3].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[3].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[3].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[3].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[3].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q5
* item[4].linkId = "sfsis_q5"
* item[4].code = SCT#737351007 "Difficulty with household tasks (finding)"
* item[4].text = "In the past 2 weeks, how difficult was it to do light household tasks/chores (eg, dust, make a bed, take out the rubbish, do the dishes)?"
* item[4].type = #coding
* item[4].required = true
* item[4].repeats = false
* item[4].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[4].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[4].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[4].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[4].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[4].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[4].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[4].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[4].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[4].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q6
* item[5].linkId = "sfsis_q6"
* item[5].code = SCT#449811004 "Stable gait (finding)"
* item[5].text = "In the past 2 weeks, how difficult was it to walk without losing balance?"
* item[5].type = #coding
* item[5].required = true
* item[5].repeats = false
* item[5].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[5].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[5].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[5].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[5].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[5].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[5].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[5].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[5].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[5].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q7
* item[6].linkId = "sfsis_q7"
* item[6].code = SCT#284180008 "Ability to perform hand functions (observable entity)"
* item[6].text = "In the past 2 weeks, how difficult was it to use your hand that was most affected by your stroke, to pick up a coin?"
* item[6].type = #coding
* item[6].required = true
* item[6].repeats = false
* item[6].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[6].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[6].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[6].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[6].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[6].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[6].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[6].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[6].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[6].answerOption[4].extension[ItemWeight].valueDecimal = 5
// sfsis_q8
* item[7].linkId = "sfsis_q8"
* item[7].code = SCT#405075006 "Social involvement behavior (observable entity)"
* item[7].text = "During the past 4 weeks, how much of the time have you been limited in your social activities?"
* item[7].type = #coding
* item[7].required = true
* item[7].repeats = false
* item[7].answerOption[0].valueCoding = SfSisAnswersCS#1 "Could not do it at all"
* item[7].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[7].answerOption[1].valueCoding = SfSisAnswersCS#2 "Very difficult"
* item[7].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[7].answerOption[2].valueCoding = SfSisAnswersCS#3 "Somewhat difficult"
* item[7].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[7].answerOption[3].valueCoding = SfSisAnswersCS#4 "A little difficult"
* item[7].answerOption[3].extension[ItemWeight].valueDecimal = 4
* item[7].answerOption[4].valueCoding = SfSisAnswersCS#5 "Not difficult at all"
* item[7].answerOption[4].extension[ItemWeight].valueDecimal = 5

Instance: SfNeadlQuestionnaire
InstanceOf: PatientReportedOutcomeQuestionnaires
Usage: #definition
Title: "SF-NEADL Questionnaire"
Description: "Short-form Nottingham Extended Activities of Daily Living Questionnaire. Five items, each scored 1-4 over the same four SNOMED CT independence answers."
* id = "sf-neadl-questionnaire"
* url = "http://fhir.qualityregistry.org/Questionnaire/sf-neadl-questionnaire"
* identifier[0].system = "http://fhir.qualityregistry.org/identifier/questionnaire-resource-id"
* identifier[0].value = "sf-neadl_001"
* identifier[1].system = "urn:ietf:rfc:3986"
* identifier[1].value = "https://qualityregistry.org/questionnaires/sf-neadl"
* version = "1.0.0"
* name = "SFNEADLQuestionnaire"
* status = #active
* experimental = false
* date = "2026-03-05"
* publisher = "Stroke Quality Registry"
* code[0] = RESQQuestionnairesCS#sfneadl "short-form Nottingham Extended Activities of Daily Living"
// sfneadl_q1
* item[0].linkId = "sfneadl_q1"
* item[0].code = SCT#716424007 "Able to mobilize over uneven ground (finding)"
* item[0].text = "In the past week, did you walk over uneven ground?"
* item[0].type = #coding
* item[0].required = true
* item[0].repeats = false
* item[0].answerOption[0].valueCoding = SCT#371151008 "Unable"
* item[0].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[0].answerOption[1].valueCoding = SCT#371154000 "Dependent"
* item[0].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[0].answerOption[2].valueCoding = SCT#371157007 "Able with difficulty"
* item[0].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[0].answerOption[3].valueCoding = SCT#371153006 "Independently able"
* item[0].answerOption[3].extension[ItemWeight].valueDecimal = 4
// sfneadl_q2
* item[1].linkId = "sfneadl_q2"
* item[1].code = SCT#300669004 "Ability to cross the road (observable entity)"
* item[1].text = "In the past week, did you cross roads?"
* item[1].type = #coding
* item[1].required = true
* item[1].repeats = false
* item[1].answerOption[0].valueCoding = SCT#371151008 "Unable"
* item[1].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[1].answerOption[1].valueCoding = SCT#371154000 "Dependent"
* item[1].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[1].answerOption[2].valueCoding = SCT#371157007 "Able with difficulty"
* item[1].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[1].answerOption[3].valueCoding = SCT#371153006 "Independently able"
* item[1].answerOption[3].extension[ItemWeight].valueDecimal = 4
// sfneadl_q3
* item[2].linkId = "sfneadl_q3"
* item[2].code = SupplementalQuestionsCS#sfneadl_q3_custom "In the past week, did you take hot drinks from one room to another?"
* item[2].text = "In the past week, did you take hot drinks from one room to another?"
* item[2].type = #coding
* item[2].required = true
* item[2].repeats = false
* item[2].answerOption[0].valueCoding = SCT#371151008 "Unable"
* item[2].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[2].answerOption[1].valueCoding = SCT#371154000 "Dependent"
* item[2].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[2].answerOption[2].valueCoding = SCT#371157007 "Able with difficulty"
* item[2].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[2].answerOption[3].valueCoding = SCT#371153006 "Independently able"
* item[2].answerOption[3].extension[ItemWeight].valueDecimal = 4
// sfneadl_q4
* item[3].linkId = "sfneadl_q4"
* item[3].code = SCT#286085003 "Ability to do washing-up (observable entity)"
* item[3].text = "In the past week, did you do the washing up?"
* item[3].type = #coding
* item[3].required = true
* item[3].repeats = false
* item[3].answerOption[0].valueCoding = SCT#371151008 "Unable"
* item[3].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[3].answerOption[1].valueCoding = SCT#371154000 "Dependent"
* item[3].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[3].answerOption[2].valueCoding = SCT#371157007 "Able with difficulty"
* item[3].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[3].answerOption[3].valueCoding = SCT#371153006 "Independently able"
* item[3].answerOption[3].extension[ItemWeight].valueDecimal = 4
// sfneadl_q5
* item[4].linkId = "sfneadl_q5"
* item[4].code = SCT#286452004 "Ability to prepare food for eating (observable entity)"
* item[4].text = "In the past week, do you make yourself a hot snack?"
* item[4].type = #coding
* item[4].required = true
* item[4].repeats = false
* item[4].answerOption[0].valueCoding = SCT#371151008 "Unable"
* item[4].answerOption[0].extension[ItemWeight].valueDecimal = 1
* item[4].answerOption[1].valueCoding = SCT#371154000 "Dependent"
* item[4].answerOption[1].extension[ItemWeight].valueDecimal = 2
* item[4].answerOption[2].valueCoding = SCT#371157007 "Able with difficulty"
* item[4].answerOption[2].extension[ItemWeight].valueDecimal = 3
* item[4].answerOption[3].valueCoding = SCT#371153006 "Independently able"
* item[4].answerOption[3].extension[ItemWeight].valueDecimal = 4
