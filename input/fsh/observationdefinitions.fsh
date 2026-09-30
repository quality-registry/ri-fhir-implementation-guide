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
// are, however, exactly "the more severe of the two component bands", so each
// component is banded on its own here and that combination rule is stated in the
// description. sva-bp-under-85-interpretation and sva-bp-85-plus-interpretation
// on SelfReportedValueAggregationProfile enforce it on the Observation.
//
// The table in each description is also the machine-readable form of the rules.
// The interpretation-rules comment above it (hidden when the markdown is rendered)
// names the SNOMED CT code of the component in each value column, in order. Each
// row is one rule: the component ranges, "or" / "and" between them, and the
// interpretation code first in the last column. Rows are read from the top and
// the first one met applies. A range is written "≥ low", "< high" or
// "≥ low and < high", following the band convention of this guide.
//
// One definition per age group rather than one with age-qualified bands, so an
// aggregation can name the table it was assessed against in
// Observation.instantiatesCanonical. The bands still carry qualifiedValue.age
// for a reader of the definition alone. The age bound follows the band
// convention: under 85 excludes 85, 85 and over includes it.
// -----------------------------------------------------------------------------

Instance: SelfReportedBloodPressureAssessmentUnder85
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Self-Reported Blood Pressure Assessment, Under 85"
Description: "The criteria used to assess a patient's aggregated self-reported blood pressure, for patients under 85 years old."
* id = "self-reported-blood-pressure-assessment-under-85"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/self-reported-blood-pressure-assessment-under-85"
* name = "SelfReportedBloodPressureAssessmentUnder85"
* title = "Self-Reported Blood Pressure Assessment, Under 85"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation, for patients under 85 years old. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N, L. Each band includes its lower bound and excludes its upper bound.

<!-- interpretation-rules: 314440001 314453003 -->
| Mean SBP (mmHg) | | Mean DBP (mmHg) | Interpretation |
| --- | --- | --- | --- |
| ≥ 135 | or | ≥ 85 | HU Significantly high: above home hypertension threshold |
| ≥ 130 and < 135 | or | ≥ 80 and < 85 | H High: above ESC treatment target |
| ≥ 120 and < 130 | and | < 80 | N Normal: within ESC treatment target |
| < 120 | and | < 80 | L Low: below ESC treatment target |

Diastolic pressure has no band of its own for N: below 80 mmHg it is banded L, so the overall interpretation is set by the systolic average.
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation, for patients under 85 years old. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N, L. Each band includes its lower bound and excludes its upper bound.</p>
<table class="grid">
<tr><th>Mean SBP (mmHg)</th><th></th><th>Mean DBP (mmHg)</th><th>Interpretation</th></tr>
<tr><td>&#8805; 135</td><td>or</td><td>&#8805; 85</td><td>HU Significantly high: above home hypertension threshold</td></tr>
<tr><td>&#8805; 130 and &lt; 135</td><td>or</td><td>&#8805; 80 and &lt; 85</td><td>H High: above ESC treatment target</td></tr>
<tr><td>&#8805; 120 and &lt; 130</td><td>and</td><td>&lt; 80</td><td>N Normal: within ESC treatment target</td></tr>
<tr><td>&lt; 120</td><td>and</td><td>&lt; 80</td><td>L Low: below ESC treatment target</td></tr>
</table>
<p>Diastolic pressure has no band of its own for N: below 80 mmHg it is banded L, so the overall interpretation is set by the systolic average.</p>
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

* component[1].code = SCT#314453003 "Average diastolic blood pressure (observable entity)"
* component[1].permittedDataType = #Quantity
* component[1].permittedUnit = UCUM#mm[Hg] "millimeter of mercury"

* component[1].qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept.text = "Below ESC treatment target"
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

Instance: SelfReportedBloodPressureAssessment85Plus
InstanceOf: ObservationDefinition
Usage: #definition
Title: "Self-Reported Blood Pressure Assessment, 85 and Over"
Description: "The criteria used to assess a patient's aggregated self-reported blood pressure, for patients aged 85 years and over."
* id = "self-reported-blood-pressure-assessment-85-plus"
* url = "http://fhir.qualityregistry.org/ObservationDefinition/self-reported-blood-pressure-assessment-85-plus"
* name = "SelfReportedBloodPressureAssessment85Plus"
* title = "Self-Reported Blood Pressure Assessment, 85 and Over"
* status = #active
* experimental = false
* description = """
The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation, for patients aged 85 years and over. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N, L. Each band includes its lower bound and excludes its upper bound.

<!-- interpretation-rules: 314440001 314453003 -->
| Mean SBP (mmHg) | | Mean DBP (mmHg) | Interpretation |
| --- | --- | --- | --- |
| ≥ 140 | or | ≥ 85 | HU Significantly high: above home hypertension threshold |
| < 140 | and | ≥ 80 and < 85 | H High: above ESC treatment target |
| ≥ 120 and < 140 | and | < 80 | N Normal: within age-adjusted treatment target |
| < 120 | and | < 80 | L Low: below ESC treatment target |

The treatment target is adjusted for age: systolic pressure below 140 mmHg is within target, and systolic pressure has no H band, going straight from N to HU at 140 mmHg. Diastolic pressure has no band for N: below 80 mmHg it is banded L, so the overall interpretation is then set by the systolic average.
"""
// Authored rather than generated, for the same reason as the glucose definition.
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
<p>The criteria the registry applies to a patient's aggregated self-reported blood pressure to set its Observation.interpretation, for patients aged 85 years and over. Average systolic and average diastolic pressure are each banded on their own, and the overall interpretation is the more severe of the two, in the order HU, H, N, L. Each band includes its lower bound and excludes its upper bound.</p>
<table class="grid">
<tr><th>Mean SBP (mmHg)</th><th></th><th>Mean DBP (mmHg)</th><th>Interpretation</th></tr>
<tr><td>&#8805; 140</td><td>or</td><td>&#8805; 85</td><td>HU Significantly high: above home hypertension threshold</td></tr>
<tr><td>&lt; 140</td><td>and</td><td>&#8805; 80 and &lt; 85</td><td>H High: above ESC treatment target</td></tr>
<tr><td>&#8805; 120 and &lt; 140</td><td>and</td><td>&lt; 80</td><td>N Normal: within age-adjusted treatment target</td></tr>
<tr><td>&lt; 120</td><td>and</td><td>&lt; 80</td><td>L Low: below ESC treatment target</td></tr>
</table>
<p>The treatment target is adjusted for age: systolic pressure below 140 mmHg is within target, and systolic pressure has no H band, going straight from N to HU at 140 mmHg. Diastolic pressure has no band for N: below 80 mmHg it is banded L, so the overall interpretation is then set by the systolic average.</p>
</div>"""
* code = SCT#723232008 "Average blood pressure (observable entity)"

* component[0].code = SCT#314440001 "Average systolic blood pressure (observable entity)"
* component[0].permittedDataType = #Quantity
* component[0].permittedUnit = UCUM#mm[Hg] "millimeter of mercury"

* component[0].qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* component[0].qualifiedValue[0].extension[0].valueCodeableConcept.text = "Below ESC treatment target"
* component[0].qualifiedValue[0].age.low = 85 'a' "years"
* component[0].qualifiedValue[0].range.high = 120 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#N "Normal"
* component[0].qualifiedValue[1].extension[0].valueCodeableConcept.text = "Within age-adjusted treatment target"
* component[0].qualifiedValue[1].rangeCategory = #reference
* component[0].qualifiedValue[1].age.low = 85 'a' "years"
* component[0].qualifiedValue[1].range.low = 120 'mm[Hg]' "mmHg"
* component[0].qualifiedValue[1].range.high = 140 'mm[Hg]' "mmHg"

* component[0].qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[0].qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[0].qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[0].qualifiedValue[2].age.low = 85 'a' "years"
* component[0].qualifiedValue[2].range.low = 140 'mm[Hg]' "mmHg"

* component[1].code = SCT#314453003 "Average diastolic blood pressure (observable entity)"
* component[1].permittedDataType = #Quantity
* component[1].permittedUnit = UCUM#mm[Hg] "millimeter of mercury"

* component[1].qualifiedValue[0].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept = ObservationInterpretationCS#L "Low"
* component[1].qualifiedValue[0].extension[0].valueCodeableConcept.text = "Below ESC treatment target"
* component[1].qualifiedValue[0].age.low = 85 'a' "years"
* component[1].qualifiedValue[0].range.high = 80 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[1].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[1].extension[0].valueCodeableConcept = ObservationInterpretationCS#H "High"
* component[1].qualifiedValue[1].extension[0].valueCodeableConcept.text = "Above ESC treatment target"
* component[1].qualifiedValue[1].age.low = 85 'a' "years"
* component[1].qualifiedValue[1].range.low = 80 'mm[Hg]' "mmHg"
* component[1].qualifiedValue[1].range.high = 85 'mm[Hg]' "mmHg"

* component[1].qualifiedValue[2].extension[0].url = "http://fhir.qualityregistry.org/StructureDefinition/qualified-value-interpretation-ext"
* component[1].qualifiedValue[2].extension[0].valueCodeableConcept = ObservationInterpretationCS#HU "Significantly high"
* component[1].qualifiedValue[2].extension[0].valueCodeableConcept.text = "Above home hypertension threshold"
* component[1].qualifiedValue[2].age.low = 85 'a' "years"
* component[1].qualifiedValue[2].range.low = 85 'mm[Hg]' "mmHg"
