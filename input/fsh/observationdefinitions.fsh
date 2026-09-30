// -----------------------------------------------------------------------------
// ObservationDefinitions
//
// The criteria the registry applies when it assesses a self-reported reading.
// Each qualifiedValue is one band of the scale, and
// QualifiedValueInterpretationExt names the Observation.interpretation code a
// reading in that band receives. The bands use the same codes as
// SelfReportedInterpretationVS.
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
