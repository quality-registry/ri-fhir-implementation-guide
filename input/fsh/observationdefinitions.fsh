// -----------------------------------------------------------------------------
// ObservationDefinitions
//
// The criteria the registry applies when it assesses a self-reported reading
// or a score. Each qualifiedValue is one band of the scale, and
// QualifiedValueInterpretationExt names the Observation.interpretation code a
// value in that band receives. The reading bands use the same codes as
// SelfReportedInterpretationVS; the score bands, at the end of this file, use
// ScoreSeverityInterpretationVS.
//
// Bands are half-open: the lower bound is inclusive and the upper bound is
// exclusive, so each band's range.high equals the next band's range.low exactly
// and every value falls into exactly one band, with no rounding. This departs
// from the default reading of FHIR Range, whose bounds are both inclusive, and
// is stated in each definition's description and narrative. It is implicit
// rather than carried in an extension.
// -----------------------------------------------------------------------------

Instance: SelfReportedGlucoseAssessment
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Self-Reported Glucose Assessment"
Description: "The criteria used to assess a patient's self-reported glucose reading."
* id = "self-reported-glucose-assessment"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/self-reported-glucose-assessment"
* name = "SelfReportedGlucoseAssessment"
* title = "Self-Reported Glucose Assessment"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a self-reported glucose reading to set its Observation.interpretation. Each band includes its lower bound and excludes its upper bound.

| Glucose (mmol/L) | Interpretation | Meaning |
| --- | --- | --- |
| < 4.0 | L Low | Below optimal level, risk of hypoglycemia |
| ≥ 4.0 and < 7.0 | N Normal | Optimal level |
| ≥ 7.0 and < 10.0 | H High | Above optimal level |
| ≥ 10.0 | HU Significantly high | Above recommended level |
"""
// Authored rather than generated: the Publisher's default narrative prints url
// as a hyperlink, which does not resolve because the canonical is not served.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>Criteria for assessing a self-reported glucose reading (SNOMED CT 33747003), in mmol/L. Each band includes its lower bound and excludes its upper bound.</p>
<table class="grid">
<tr><th>Glucose (mmol/L)</th><th>Interpretation</th><th>Meaning</th></tr>
<tr><td>&lt; 4.0</td><td>L Low</td><td>Below optimal level, risk of hypoglycemia</td></tr>
<tr><td>&#8805; 4.0 and &lt; 7.0</td><td>N Normal (reference range)</td><td>Optimal level</td></tr>
<tr><td>&#8805; 7.0 and &lt; 10.0</td><td>H High</td><td>Above optimal level</td></tr>
<tr><td>&#8805; 10.0</td><td>HU Significantly high</td><td>Above recommended level</td></tr>
</table>
</div>"""
* code = SCT#33747003 "Glucose measurement, blood (procedure)"
* permittedDataType = #Quantity
* permittedUnit = UCUM#mmol/L "millimole per liter"

* qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* qualifiedValue[0].extension[0].valueCodeableConcept.text = "Below optimal level, risk of hypoglycemia"
* qualifiedValue[0].range.high = 4.0 'mmol/L' "mmol/L"

* qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* qualifiedValue[1].extension[0].valueCodeableConcept.text = "Optimal level"
* qualifiedValue[1].rangeCategory = #reference
* qualifiedValue[1].range.low = 4.0 'mmol/L' "mmol/L"
* qualifiedValue[1].range.high = 7.0 'mmol/L' "mmol/L"

* qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above optimal level"
* qualifiedValue[2].range.low = 7.0 'mmol/L' "mmol/L"
* qualifiedValue[2].range.high = 10.0 'mmol/L' "mmol/L"

* qualifiedValue[3].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[3].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* qualifiedValue[3].extension[0].valueCodeableConcept.text = "Above recommended level"
* qualifiedValue[3].range.low = 10.0 'mmol/L' "mmol/L"

Instance: SelfReportedLdlCholesterolAssessment
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Self-Reported LDL Cholesterol Assessment"
Description: "The criteria used to assess a patient's self-reported LDL cholesterol reading."
* id = "self-reported-ldl-cholesterol-assessment"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/self-reported-ldl-cholesterol-assessment"
* name = "SelfReportedLdlCholesterolAssessment"
* title = "Self-Reported LDL Cholesterol Assessment"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a self-reported LDL cholesterol reading to set its Observation.interpretation. Each band includes its lower bound and excludes its upper bound.

| LDL cholesterol (mmol/L) | Interpretation | Meaning |
| --- | --- | --- |
| < 1.40 | N Normal | Optimal level |
| ≥ 1.40 and < 1.80 | H High | Above optimal level |
| ≥ 1.80 | HU Significantly high | Above recommended level |
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>Criteria for assessing a self-reported LDL cholesterol reading (SNOMED CT 372361000119104), in mmol/L. Each band includes its lower bound and excludes its upper bound.</p>
<table class="grid">
<tr><th>LDL cholesterol (mmol/L)</th><th>Interpretation</th><th>Meaning</th></tr>
<tr><td>&lt; 1.40</td><td>N Normal (reference range)</td><td>Optimal level</td></tr>
<tr><td>&#8805; 1.40 and &lt; 1.80</td><td>H High</td><td>Above optimal level</td></tr>
<tr><td>&#8805; 1.80</td><td>HU Significantly high</td><td>Above recommended level</td></tr>
</table>
</div>"""
* code = SCT#372361000119104 "Low density lipoprotein cholesterol by direct assay (observable entity)"
* permittedDataType = #Quantity
* permittedUnit = UCUM#mmol/L "millimole per liter"

* qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* qualifiedValue[0].extension[0].valueCodeableConcept.text = "Optimal level"
* qualifiedValue[0].rangeCategory = #reference
* qualifiedValue[0].range.high = 1.40 'mmol/L' "mmol/L"

* qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* qualifiedValue[1].extension[0].valueCodeableConcept.text = "Above optimal level"
* qualifiedValue[1].range.low = 1.40 'mmol/L' "mmol/L"
* qualifiedValue[1].range.high = 1.80 'mmol/L' "mmol/L"

* qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above recommended level"
* qualifiedValue[2].range.low = 1.80 'mmol/L' "mmol/L"

// -----------------------------------------------------------------------------
// Aggregated blood pressure
//
// The registry's tables judge blood pressure on the systolic and diastolic
// averages together ("SBP at least 135 OR DBP at least 85"), which
// ObservationDefinition cannot state: each component carries its own
// qualifiedValue bands and there is no element for combining them. The tables
// are, however, "the more severe of the two component bands", with systolic
// pressure alone deciding below target because diastolic pressure has no L band,
// so each component is banded on its own here and that combination rule is
// stated in the description.
//
// One definition covers both age groups. Every band carries qualifiedValue.age,
// under 85 first and then 85 and over, and the assessment table has an age
// column. The age bound follows the band convention: under 85 excludes 85,
// 85 and over includes it. An aggregation records which rows applied in
// AdjustedInterpretationForAgeExt.
//
// The tables in the description are also the machine-readable form of the rules.
// The interpretation-rules comment above the assessment table (hidden when the
// markdown is rendered) names the SNOMED CT code of the component in each value
// column, in order, after "age" for the leading age column. Each row is one
// rule: the age range, the component ranges, "or" / "and" between them, and the
// interpretation code first in the last column. Rows are read from the top and
// the first one met for the patient's age applies. A range is written "≥ low",
// "< high" or "≥ low and < high", following the band convention of this guide.
// A blank value cell, with a blank relation beside it, puts no condition on
// that component.
//
// The extra-rules comment above the second table names the individual
// readings (not the averages) the critical rule applies to. Its row adds the
// minimum number of readings and the window they must fall within. The rule
// counts readings over time, which ObservationDefinition cannot express, so it
// is published in the tables only and has no qualifiedValue.
// -----------------------------------------------------------------------------

Instance: SelfReportedBloodPressureAssessment
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Self-Reported Blood Pressure Assessment"
Description: "The criteria used to assess a patient's aggregated self-reported blood pressure."
* id = "self-reported-blood-pressure-assessment"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/self-reported-blood-pressure-assessment"
* name = "SelfReportedBloodPressureAssessment"
* title = "Self-Reported Blood Pressure Assessment"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N; below target it is set by the systolic average, which alone has an L band. The bands depend on the patient's age: for patients aged 85 years and over the treatment target is adjusted. Each band includes its lower bound and excludes its upper bound.

<!-- interpretation-rules: age 314440001 314453003 -->
| Age (years) | Mean SBP (mmHg) | | Mean DBP (mmHg) | Interpretation |
| --- | --- | --- | --- | --- |
| < 85 | ≥ 135 | or | ≥ 85 | HU Significantly high: above home hypertension threshold |
| < 85 | ≥ 130 and < 135 | or | ≥ 80 and < 85 | H High: above ESC treatment target |
| < 85 | ≥ 120 and < 130 | and | < 80 | N Normal: within ESC treatment target |
| < 85 | < 120 | | | L Low: below ESC treatment target |
| ≥ 85 | ≥ 140 | or | ≥ 85 | HU Significantly high: above home hypertension threshold |
| ≥ 85 | < 140 | and | ≥ 80 and < 85 | H High: above ESC treatment target |
| ≥ 85 | ≥ 120 and < 140 | and | < 80 | N Normal: within age-adjusted treatment target |
| ≥ 85 | < 120 | | | L Low: below ESC treatment target |

Diastolic pressure below 80 mmHg is within target (N) in both age groups and has no L band, so L is set by the systolic average alone and its rows leave diastolic pressure blank. For patients aged 85 and over the treatment target is adjusted for age: systolic pressure below 140 mmHg is within target, and systolic pressure has no H band, going straight from N to HU at 140 mmHg.

Critical values are judged on the individual readings behind the aggregation rather than on the averages. When the rule below is met, the interpretation is HH, whatever the averages are.

<!-- extra-rules: 271649006 271650006 -->
| SBP (mmHg) | | DBP (mmHg) | Readings | Within | Interpretation |
| --- | --- | --- | --- | --- | --- |
| ≥ 180 | or | ≥ 110 | ≥ 2 | 48 h | HH Critical high: at least two readings at crisis level within 48 hours |

The critical rule counts readings over time, which an ObservationDefinition cannot express, so it is stated in this table only and has no qualifiedValue.
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N; below target it is set by the systolic average, which alone has an L band. The bands depend on the patient's age: for patients aged 85 years and over the treatment target is adjusted. Each band includes its lower bound and excludes its upper bound.</p>
<table class="grid">
<tr><th>Age (years)</th><th>Mean SBP (mmHg)</th><th></th><th>Mean DBP (mmHg)</th><th>Interpretation</th></tr>
<tr><td>&lt; 85</td><td>&#8805; 135</td><td>or</td><td>&#8805; 85</td><td>HU Significantly high: above home hypertension threshold</td></tr>
<tr><td>&lt; 85</td><td>&#8805; 130 and &lt; 135</td><td>or</td><td>&#8805; 80 and &lt; 85</td><td>H High: above ESC treatment target</td></tr>
<tr><td>&lt; 85</td><td>&#8805; 120 and &lt; 130</td><td>and</td><td>&lt; 80</td><td>N Normal: within ESC treatment target</td></tr>
<tr><td>&lt; 85</td><td>&lt; 120</td><td></td><td></td><td>L Low: below ESC treatment target</td></tr>
<tr><td>&#8805; 85</td><td>&#8805; 140</td><td>or</td><td>&#8805; 85</td><td>HU Significantly high: above home hypertension threshold</td></tr>
<tr><td>&#8805; 85</td><td>&lt; 140</td><td>and</td><td>&#8805; 80 and &lt; 85</td><td>H High: above ESC treatment target</td></tr>
<tr><td>&#8805; 85</td><td>&#8805; 120 and &lt; 140</td><td>and</td><td>&lt; 80</td><td>N Normal: within age-adjusted treatment target</td></tr>
<tr><td>&#8805; 85</td><td>&lt; 120</td><td></td><td></td><td>L Low: below ESC treatment target</td></tr>
</table>
<p>Diastolic pressure below 80 mmHg is within target (N) in both age groups and has no L band, so L is set by the systolic average alone and its rows leave diastolic pressure blank. For patients aged 85 and over the treatment target is adjusted for age: systolic pressure below 140 mmHg is within target, and systolic pressure has no H band, going straight from N to HU at 140 mmHg.</p>
<p>Critical values are judged on the individual readings behind the aggregation rather than on the averages. When the rule below is met, the interpretation is HH, whatever the averages are.</p>
<table class="grid">
<tr><th>SBP (mmHg)</th><th></th><th>DBP (mmHg)</th><th>Readings</th><th>Within</th><th>Interpretation</th></tr>
<tr><td>&#8805; 180</td><td>or</td><td>&#8805; 110</td><td>&#8805; 2</td><td>48 h</td><td>HH Critical high: at least two readings at crisis level within 48 hours</td></tr>
</table>
<p>The critical rule counts readings over time, which an ObservationDefinition cannot express, so it is stated in this table only and has no qualifiedValue.</p>
</div>"""
* code = SCT#723232008 "Average blood pressure (observable entity)"

* component[0].code = SCT#314440001 "Average systolic blood pressure (observable entity)"
* component[0].permittedDataType = #Quantity
* component[0].permittedUnit = UCUM#mm[Hg] "millimeter of mercury"

* component[0].qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* component[0].qualifiedValue[0].extension[0].valueCodeableConcept.text = "Below ESC treatment target"
* component[0].qualifiedValue[0].age.high = 85 'a' "years"
* component[0].qualifiedValue[0].range.high = 120 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* component[0].qualifiedValue[1].extension[0].valueCodeableConcept.text = "Within ESC treatment target"
* component[0].qualifiedValue[1].rangeCategory = #reference
* component[0].qualifiedValue[1].age.high = 85 'a' "years"
* component[0].qualifiedValue[1].range.low = 120 'mm[Hg]' "mmHg"
* component[0].qualifiedValue[1].range.high = 130 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* component[0].qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above ESC treatment target"
* component[0].qualifiedValue[2].age.high = 85 'a' "years"
* component[0].qualifiedValue[2].range.low = 130 'mm[Hg]' "mmHg"
* component[0].qualifiedValue[2].range.high = 135 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[3].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[3].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[0].qualifiedValue[3].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[0].qualifiedValue[3].age.high = 85 'a' "years"
* component[0].qualifiedValue[3].range.low = 135 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[4].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[4].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* component[0].qualifiedValue[4].extension[0].valueCodeableConcept.text = "Below ESC treatment target"
* component[0].qualifiedValue[4].age.low = 85 'a' "years"
* component[0].qualifiedValue[4].range.high = 120 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[5].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[5].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* component[0].qualifiedValue[5].extension[0].valueCodeableConcept.text = "Within age-adjusted treatment target"
* component[0].qualifiedValue[5].rangeCategory = #reference
* component[0].qualifiedValue[5].age.low = 85 'a' "years"
* component[0].qualifiedValue[5].range.low = 120 'mm[Hg]' "mmHg"
* component[0].qualifiedValue[5].range.high = 140 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[6].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[6].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[0].qualifiedValue[6].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[0].qualifiedValue[6].age.low = 85 'a' "years"
* component[0].qualifiedValue[6].range.low = 140 'mm[Hg]' "mmHg"

* component[1].code = SCT#314453003 "Average diastolic blood pressure (observable entity)"
* component[1].permittedDataType = #Quantity
* component[1].permittedUnit = UCUM#mm[Hg] "millimeter of mercury"

* component[1].qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept.text = "Within ESC treatment target"
* component[1].qualifiedValue[0].rangeCategory = #reference
* component[1].qualifiedValue[0].age.high = 85 'a' "years"
* component[1].qualifiedValue[0].range.high = 80 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* component[1].qualifiedValue[1].extension[0].valueCodeableConcept.text = "Above ESC treatment target"
* component[1].qualifiedValue[1].age.high = 85 'a' "years"
* component[1].qualifiedValue[1].range.low = 80 'mm[Hg]' "mmHg"
* component[1].qualifiedValue[1].range.high = 85 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[1].qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[1].qualifiedValue[2].age.high = 85 'a' "years"
* component[1].qualifiedValue[2].range.low = 85 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[3].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[3].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* component[1].qualifiedValue[3].extension[0].valueCodeableConcept.text = "Within ESC treatment target"
* component[1].qualifiedValue[3].rangeCategory = #reference
* component[1].qualifiedValue[3].age.low = 85 'a' "years"
* component[1].qualifiedValue[3].range.high = 80 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[4].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[4].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* component[1].qualifiedValue[4].extension[0].valueCodeableConcept.text = "Above ESC treatment target"
* component[1].qualifiedValue[4].age.low = 85 'a' "years"
* component[1].qualifiedValue[4].range.low = 80 'mm[Hg]' "mmHg"
* component[1].qualifiedValue[4].range.high = 85 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[5].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[5].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[1].qualifiedValue[5].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[1].qualifiedValue[5].age.low = 85 'a' "years"
* component[1].qualifiedValue[5].range.low = 85 'mm[Hg]' "mmHg"

// -----------------------------------------------------------------------------
// Score severity assessments
//
// Ordinal clinical scales are interpreted with the SNOMED CT severity qualifiers
// collected in ScoreSeverityInterpretationVS rather than with the HL7
// ObservationInterpretation flags above: a score says how severe a condition is,
// not whether a value is above or below a target.
//
// A score is a whole number, carried as a Quantity in the UCUM unit {score}.
// qualifiedValue can only express a Range, so a band holding a single score n
// is written as the half-open range from n to n + 1, the same convention as the
// other definitions. Unlike them, the outermost bands are bounded by the ends of
// the scale, so every band names the exact scores it holds and a score outside
// the scale is not interpreted.
//
// Each definition is keyed on Observation.code only, so it applies to the score
// wherever it is recorded: the mRS definition covers the pre-stroke, discharge
// and three-month hospital scores as well as the patient-reported one.
// -----------------------------------------------------------------------------

Instance: MrsSeverityAssessment
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Modified Rankin Scale Severity Assessment"
Description: "The criteria used to assess the severity a modified Rankin Scale (mRS) score indicates."
* id = "mrs-severity-assessment"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/mrs-severity-assessment"
* name = "MrsSeverityAssessment"
* title = "Modified Rankin Scale Severity Assessment"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a modified Rankin Scale (mRS) score to set its Observation.interpretation. Each mRS grade has a band of its own, from no symptoms to death. The score is a whole number from 0 to 6, carried in valueQuantity with the UCUM unit {score}. As in every definition of this guide, each band includes its lower bound and excludes its upper bound, so for a whole-number score the band from n to n + 1 holds the single score n; the table lists the scores each band holds. A score outside 0 to 6 falls in no band and receives no interpretation.

| mRS score | Interpretation | Meaning |
| --- | --- | --- |
| 0 | 371928007 Not significant | No symptoms at all |
| 1 | 255604002 Mild | No significant disability despite symptoms |
| 2 | 371923003 Mild to moderate | Slight disability |
| 3 | 1255665007 Moderate | Moderate disability |
| 4 | 371924009 Moderate to severe | Moderately severe disability |
| 5 | 24484000 Severe | Severe disability |
| 6 | 419099009 Dead | Dead |
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>Criteria for assessing the severity a modified Rankin Scale (mRS) score (SNOMED CT 1255866005) indicates. The score is a whole number from 0 to 6, in the UCUM unit {score}. Each band includes its lower bound and excludes its upper bound; the table lists the scores each band holds.</p>
<table class="grid">
<tr><th>mRS score</th><th>Interpretation</th><th>Meaning</th></tr>
<tr><td>0</td><td>371928007 Not significant (reference range)</td><td>No symptoms at all</td></tr>
<tr><td>1</td><td>255604002 Mild</td><td>No significant disability despite symptoms</td></tr>
<tr><td>2</td><td>371923003 Mild to moderate</td><td>Slight disability</td></tr>
<tr><td>3</td><td>1255665007 Moderate</td><td>Moderate disability</td></tr>
<tr><td>4</td><td>371924009 Moderate to severe</td><td>Moderately severe disability</td></tr>
<tr><td>5</td><td>24484000 Severe</td><td>Severe disability</td></tr>
<tr><td>6</td><td>419099009 Dead</td><td>Dead</td></tr>
</table>
</div>"""
* code = SCT#1255866005 "Modified Rankin Scale score (observable entity)"
* permittedDataType = #Quantity
* permittedUnit = UCUM#"{score}" "{score}"

* qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[0].extension[0].valueCodeableConcept = SCT#371928007 "Not significant (qualifier value)"
* qualifiedValue[0].extension[0].valueCodeableConcept.text = "No symptoms at all"
* qualifiedValue[0].rangeCategory = #reference
* qualifiedValue[0].range.low = 0 '{score}' "{score}"
* qualifiedValue[0].range.high = 1 '{score}' "{score}"

* qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[1].extension[0].valueCodeableConcept = SCT#255604002 "Mild (qualifier value)"
* qualifiedValue[1].extension[0].valueCodeableConcept.text = "No significant disability despite symptoms"
* qualifiedValue[1].range.low = 1 '{score}' "{score}"
* qualifiedValue[1].range.high = 2 '{score}' "{score}"

* qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[2].extension[0].valueCodeableConcept = SCT#371923003 "Mild to moderate (qualifier value)"
* qualifiedValue[2].extension[0].valueCodeableConcept.text = "Slight disability"
* qualifiedValue[2].range.low = 2 '{score}' "{score}"
* qualifiedValue[2].range.high = 3 '{score}' "{score}"

* qualifiedValue[3].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[3].extension[0].valueCodeableConcept = SCT#1255665007 "Moderate (qualifier value)"
* qualifiedValue[3].extension[0].valueCodeableConcept.text = "Moderate disability"
* qualifiedValue[3].range.low = 3 '{score}' "{score}"
* qualifiedValue[3].range.high = 4 '{score}' "{score}"

* qualifiedValue[4].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[4].extension[0].valueCodeableConcept = SCT#371924009 "Moderate to severe (qualifier value)"
* qualifiedValue[4].extension[0].valueCodeableConcept.text = "Moderately severe disability"
* qualifiedValue[4].range.low = 4 '{score}' "{score}"
* qualifiedValue[4].range.high = 5 '{score}' "{score}"

* qualifiedValue[5].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[5].extension[0].valueCodeableConcept = SCT#24484000 "Severe (severity modifier) (qualifier value)"
* qualifiedValue[5].extension[0].valueCodeableConcept.text = "Severe disability"
* qualifiedValue[5].range.low = 5 '{score}' "{score}"
* qualifiedValue[5].range.high = 6 '{score}' "{score}"

* qualifiedValue[6].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[6].extension[0].valueCodeableConcept = SCT#419099009 "Dead (finding)"
* qualifiedValue[6].extension[0].valueCodeableConcept.text = "Dead"
* qualifiedValue[6].range.low = 6 '{score}' "{score}"
* qualifiedValue[6].range.high = 7 '{score}' "{score}"

Instance: Phq9SeverityAssessment
InstanceOf: ObservationDefinition
Usage: #definition
Title: "PHQ-9 Severity Assessment"
Description: "The criteria used to assess the severity a Patient Health Questionnaire-9 (PHQ-9) score indicates."
* id = "phq9-severity-assessment"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/phq9-severity-assessment"
* name = "Phq9SeverityAssessment"
* title = "PHQ-9 Severity Assessment"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a Patient Health Questionnaire-9 (PHQ-9) score to set its Observation.interpretation. The bands follow the PHQ-9 depression severity thresholds of 5, 10, 15 and 20: minimal depression maps to not significant and moderately severe depression to moderate to severe. The score is a whole number from 0 to 27, carried in valueQuantity with the UCUM unit {score}. As in every definition of this guide, each band includes its lower bound and excludes its upper bound, so for a whole-number score the band from n to n + 1 holds the single score n; the table lists the scores each band holds. A score outside 0 to 27 falls in no band and receives no interpretation.

| PHQ-9 score | Interpretation | Meaning |
| --- | --- | --- |
| 0–4 | 371928007 Not significant | Minimal depression |
| 5–9 | 255604002 Mild | Mild depression |
| 10–14 | 1255665007 Moderate | Moderate depression |
| 15–19 | 371924009 Moderate to severe | Moderately severe depression |
| 20–27 | 24484000 Severe | Severe depression |
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>Criteria for assessing the severity a Patient Health Questionnaire-9 (PHQ-9) score (SNOMED CT 720433000) indicates. The score is a whole number from 0 to 27, in the UCUM unit {score}. Each band includes its lower bound and excludes its upper bound; the table lists the scores each band holds.</p>
<table class="grid">
<tr><th>PHQ-9 score</th><th>Interpretation</th><th>Meaning</th></tr>
<tr><td>0&#8211;4</td><td>371928007 Not significant (reference range)</td><td>Minimal depression</td></tr>
<tr><td>5&#8211;9</td><td>255604002 Mild</td><td>Mild depression</td></tr>
<tr><td>10&#8211;14</td><td>1255665007 Moderate</td><td>Moderate depression</td></tr>
<tr><td>15&#8211;19</td><td>371924009 Moderate to severe</td><td>Moderately severe depression</td></tr>
<tr><td>20&#8211;27</td><td>24484000 Severe</td><td>Severe depression</td></tr>
</table>
</div>"""
* code = SCT#720433000 "Patient Health Questionnaire Nine Item score (observable entity)"
* permittedDataType = #Quantity
* permittedUnit = UCUM#"{score}" "{score}"

* qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[0].extension[0].valueCodeableConcept = SCT#371928007 "Not significant (qualifier value)"
* qualifiedValue[0].extension[0].valueCodeableConcept.text = "Minimal depression"
* qualifiedValue[0].rangeCategory = #reference
* qualifiedValue[0].range.low = 0 '{score}' "{score}"
* qualifiedValue[0].range.high = 5 '{score}' "{score}"

* qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[1].extension[0].valueCodeableConcept = SCT#255604002 "Mild (qualifier value)"
* qualifiedValue[1].extension[0].valueCodeableConcept.text = "Mild depression"
* qualifiedValue[1].range.low = 5 '{score}' "{score}"
* qualifiedValue[1].range.high = 10 '{score}' "{score}"

* qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[2].extension[0].valueCodeableConcept = SCT#1255665007 "Moderate (qualifier value)"
* qualifiedValue[2].extension[0].valueCodeableConcept.text = "Moderate depression"
* qualifiedValue[2].range.low = 10 '{score}' "{score}"
* qualifiedValue[2].range.high = 15 '{score}' "{score}"

* qualifiedValue[3].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[3].extension[0].valueCodeableConcept = SCT#371924009 "Moderate to severe (qualifier value)"
* qualifiedValue[3].extension[0].valueCodeableConcept.text = "Moderately severe depression"
* qualifiedValue[3].range.low = 15 '{score}' "{score}"
* qualifiedValue[3].range.high = 20 '{score}' "{score}"

* qualifiedValue[4].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* qualifiedValue[4].extension[0].valueCodeableConcept = SCT#24484000 "Severe (severity modifier) (qualifier value)"
* qualifiedValue[4].extension[0].valueCodeableConcept.text = "Severe depression"
* qualifiedValue[4].range.low = 20 '{score}' "{score}"
* qualifiedValue[4].range.high = 28 '{score}' "{score}"
