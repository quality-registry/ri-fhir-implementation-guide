// -----------------------------------------------------------------------------
// Actors participating in RES-Q stroke registry exchange
//
// These are roles, not deployments and not addresses. The canonical URL of each
// actor below is an identifier; nothing is listening at it. Service addresses,
// if published at all, belong in an Endpoint resource or in
// CapabilityStatement.implementation.
//
// Two obligation codes are used throughout:
//   SHALL:able-to-populate -- this actor produces instances of the profile
//   SHALL:handle           -- this actor must correctly process instances
//
// The registry stores three kinds of resource: ingested (submitted to it),
// created from ingested data (computed by it), and custom (authored by it).
// Only the first is accepted on submission; a profile with no Data Source
// obligation cannot be added, only exported.
// -----------------------------------------------------------------------------

RuleSet: RESQActorMetadata
* status = #active
* experimental = false
* version = "1.0.0"
* publisher = "Tecnomod / Universidad de Murcia"
* jurisdiction = urn:iso:std:iso:3166#ES "Spain"
* type = #system

Instance: RESQDataSource
InstanceOf: ActorDefinition
Usage: #definition
Title: "RES-Q Data Source"
Description: "System that submits stroke episode data to the RES-Q registry."
* insert RESQActorMetadata
* id = "resq-data-source"
* url = "http://qualityregistry.org/ActorDefinition/resq-data-source"
* name = "RESQDataSource"
* title = "RES-Q Data Source"
* description = "A hospital information system, EHR or transformation pipeline that produces RES-Q stroke episode data and submits it to the registry."
* documentation = """
The Data Source is the origin of every clinical fact in the registry. It assembles one
transaction bundle per stroke episode and submits it to the [RES-Q
Registry](ActorDefinition-resq-registry.html).

A Data Source carries a `SHALL:able-to-populate` obligation on every profile the registry
accepts, even where an individual episode has no data for it. It carries **no obligation at all**
on the profiles the registry derives or authors for itself, because it never produces them; see
[Data Exchange](exchange.html).
"""
* capabilities = Canonical(RESQDataSourceCapabilities)

Instance: RESQRegistry
InstanceOf: ActorDefinition
Usage: #definition
Title: "RES-Q Registry"
Description: "The RES-Q stroke registry: it accepts submitted stroke episode data, derives further data from it, and offers both to consuming systems."
* insert RESQActorMetadata
* id = "resq-registry"
* url = "http://qualityregistry.org/ActorDefinition/resq-registry"
* name = "RESQRegistry"
* title = "RES-Q Registry"
* description = "The RES-Q stroke registry. It receives stroke episode data from a Data Source, validates and persists it, derives further resources from what it holds, and exposes all of it to consuming systems."
* documentation = """
The registry sits between the [Data Source](ActorDefinition-resq-data-source.html) and the
[Data Consumer](ActorDefinition-resq-data-consumer.html), and stores three kinds of resource:

- **ingested** resources, submitted by a Data Source and stored as received;
- resources **created from ingested data**, computed by the registry out of what it already holds;
- **custom** resources, authored and maintained inside RES-Q itself.

Only ingested resources are accepted on submission. The other two can be exported but not added.
The registry's obligations on a profile say which kind it is:

- `SHALL:handle` **and** `SHALL:able-to-populate`, with a Data Source row present — an
  **ingested** resource. The registry accepts it on submission, stores it, and offers it back.
- `SHALL:able-to-populate` alone — a resource **created from ingested data**. No Data Source
  produces it, and an instance arriving in a submission bundle is discarded rather than stored,
  so that it cannot compete with the registry's own computation.
- `SHALL:handle` **and** `SHALL:able-to-populate`, with **no** Data Source row — a **custom**
  resource, authored inside RES-Q. The registry manages these itself; they can be exported but
  not added. The questionnaire definitions work this way.

The presence or absence of the Data Source row is what separates the first case from the third: a
profile with no Data Source obligation is not accepted on submission, whichever rows the registry
carries.

Two capability statements describe the two directions, because a single one cannot: a
CapabilityStatement allows only one `rest.resource` entry per resource type, yet `Observation`
carries both ingested resources and resources created from them.

- [Submission capabilities](CapabilityStatement-resq-registry-submission-capabilities.html) —
  the authoritative machine-readable list of what the registry **accepts** (46 profiles).
- [Query capabilities](CapabilityStatement-resq-registry-query-capabilities.html) — what the
  registry **offers** (48 profiles, timing metrics and questionnaires included).

`ActorDefinition.capabilities` below points at the submission statement, because that is the
constraining one; the query statement is linked from [Data Exchange](exchange.html).
"""
* capabilities = Canonical(RESQRegistrySubmissionCapabilities)

Instance: RESQDataConsumer
InstanceOf: ActorDefinition
Usage: #definition
Title: "RES-Q Data Consumer"
Description: "System that reads stroke episode data from the RES-Q registry."
* insert RESQActorMetadata
* id = "resq-data-consumer"
* url = "http://qualityregistry.org/ActorDefinition/resq-data-consumer"
* name = "RESQDataConsumer"
* title = "RES-Q Data Consumer"
* description = "A research, analytics, benchmarking or clinical system that queries the RES-Q registry and processes the resources it returns."
* documentation = """
A Data Consumer must correctly handle every profile the [registry](ActorDefinition-resq-registry.html)
can return, including the profiles the registry derives rather than receives. Derived resources
are indistinguishable on the wire from submitted ones; the difference is recorded here in the
guide, not in the instances.

A system may play this actor and the [Data Source](ActorDefinition-resq-data-source.html) actor
at the same time.
"""
* capabilities = Canonical(RESQDataConsumerCapabilities)
