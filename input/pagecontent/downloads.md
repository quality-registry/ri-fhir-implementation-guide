# Downloads

Everything on this page is regenerated on each build of the guide, so the contents always match the profiles, extensions and terminology published here.

## FHIR package

The NPM-style FHIR package is what validators, IG publishers and most FHIR tooling expect. It contains every StructureDefinition, ValueSet, CodeSystem, ActorDefinition and CapabilityStatement in this guide.

| Download | |
| --- | --- |
| [package.tgz](package.tgz) | FHIR package `RESQFHIRIG#1.0.0`, FHIR R5 |

To validate an instance against this guide with the [HL7 validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator):

```
java -jar validator_cli.jar my-bundle.json -version 5.0 -ig package.tgz
```

## Definitions

The conformance resources on their own — profiles, extensions, value sets, code systems, actors and capability statements — without the examples or the rendered pages.

| Format | Download |
| --- | --- |
| JSON | [definitions.json.zip](definitions.json.zip) |
| XML | [definitions.xml.zip](definitions.xml.zip) |
| Turtle | [definitions.ttl.zip](definitions.ttl.zip) |

## Examples

The example instances published in this guide.

| Format | Download |
| --- | --- |
| JSON | [examples.json.zip](examples.json.zip) |
| XML | [examples.xml.zip](examples.xml.zip) |
| Turtle | [examples.ttl.zip](examples.ttl.zip) |

## Expanded value sets

Value sets with their expansions already computed, for tooling that cannot reach a terminology server.

| Format | Download |
| --- | --- |
| JSON | [expansions.json.zip](expansions.json.zip) |
| XML | [expansions.xml.zip](expansions.xml.zip) |

## Analysis and validation aids

| Download | Contents |
| --- | --- |
| [csvs.zip](csvs.zip) | Every profile and value set as CSV, one file each |
| [excels.zip](excels.zip) | The same content as Excel workbooks |
| [schematrons.zip](schematrons.zip) | Schematron files per profile, for XML-based validation pipelines |

## The whole guide

| Download | Contents |
| --- | --- |
| [full-ig.zip](full-ig.zip) | This entire site, including every rendered page, ready to serve offline |

## Source

The FSH sources, build scripts and page content live in the project repository. The published artifacts above are generated from them by [SUSHI](https://fshschool.org/docs/sushi/) and the HL7 IG Publisher; see the repository README for how to run a build locally.
