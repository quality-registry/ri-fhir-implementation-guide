# RES-Q FHIR Implementation Guide

This is the repository of the RES-Q FHIR Implementation Guide.

## Published site

The Implementation Guide is published at:

- **Canonical URL**: <http://fhir.qualityregistry.org>

> **Note**: `CNAME` still contains `www.tecnomod-um.org`, inherited from the
> upstream repository, and does not match the canonical URL above. It also is
> not copied into `output/`, so the custom domain is dropped on every Pages
> deploy. This needs fixing before the custom domain will work.

## DNS configuration

For information about setting up the custom domain, see [DNS_SETUP.md](DNS_SETUP.md).

## Development

This IG uses SUSHI to compile the FSH resources and the HL7 FHIR IG Publisher to generate the website.

### Building with Docker (no local toolchain needed)

The `Dockerfile` is a two-stage build. Stage 1 carries the whole toolchain —
JDK 17, Node, Ruby, Jekyll and `publisher.jar` — and runs the same build
documented below. Stage 2 copies only `output/` into a Chainguard nginx image,
so none of the build tooling ships.

The runtime image is distroless: it contains no shell, package manager or
`curl`, and runs as the non-root uid 65532. That means it cannot be `exec`ed
into for debugging — inspect it with `docker cp` or `docker export`, and read
the logs with `docker logs`.

Stage 1 copies in only the build inputs: `sushi-config.yaml`, `ig.ini`,
`input/`, the two `package*.json` files and the `_updatePublisher.sh` /
`_genonce.sh` scripts. Anything else the build comes to need must be added to
the `COPY` lines.

```bash
docker build -t ri-fhir-implementation-guide:local .
```

The image serves on port 8080 and runs as a non-root user:

```bash
docker run --rm -p 8080:8080 \
  --read-only --tmpfs /tmp \
  --cap-drop ALL --security-opt no-new-privileges \
  ri-fhir-implementation-guide:local
```

Then open <http://localhost:8080>. `GET /healthz` returns `ok` and is the
endpoint for a readiness probe; the image ships no `HEALTHCHECK` because it
contains neither `curl` nor `wget` to run one with.

Only `/tmp` needs to be a tmpfs: [docker/nginx.conf](docker/nginx.conf) moves
the pid file and all five of nginx's temp paths there, and sends the access and
error logs to stdout/stderr.

The Publisher version is pinned in the `Dockerfile` and the download is
verified against a SHA-256 checksum, so the build always runs a known artifact
rather than whatever `latest` resolves to. To upgrade, bump both
`IG_PUBLISHER_VERSION` and `IG_PUBLISHER_SHA256` together; the digest for a
release comes from:

```bash
curl -sL https://api.github.com/repos/HL7/fhir-ig-publisher/releases/tags/2.3.4 \
  | grep -A2 '"name": "publisher.jar"'
```

The container build does not use `_updatePublisher.sh`. That script can only
fetch the latest release, and it also overwrites the `_*.sh` scripts from a
moving branch and then runs them. The local workflow below still uses it.

The base image is tagged `:latest` on purpose. Chainguard rebuilds these
images to pick up CVE fixes and does not keep older digests available on the
free tier, so pinning by digest would both freeze security updates and
eventually break the build when the digest is garbage-collected.

#### Read-only behaviour

The site is copied in owned by `root` at mode `444`, and the image runs as
uid 65532. A default `docker run` therefore cannot modify the served content or
anything under `/etc/nginx`, with no runtime flags required.

`--read-only` covers the remaining case: a container started explicitly as root
(`--user 0`) would otherwise be able to write into Docker's writable layer. No
image setting can prevent that, since runtime flags override image metadata, so
where this is deployed the guarantee belongs in the platform config — in
Kubernetes, `securityContext.readOnlyRootFilesystem: true` together with
`runAsNonRoot: true`.

The Dockerfile has no `EXPOSE`; the listening port is set by `listen 8080` in
[docker/nginx.conf](docker/nginx.conf) and published by the deployment config.

`.github/workflows/docker-build.yaml` runs this build on every push to `main`
and `develop` and pushes the image to the Azure Container Registry, tagged with
both the commit SHA and the branch name.

### Prerequisites

| Tool | Minimum version | Check with |
|---|---|---|
| Java (JDK) | 17 | `java -version` |
| Node.js | 18 | `node -v` |
| Ruby | 3.0 | `ruby -v` |
| Jekyll | 4.0 | `jekyll -v` |
| curl | any | `curl --version` |

Ruby and Jekyll are required by the build: the IG Publisher shells out to
`jekyll` to render the narrative pages in `input/pagecontent/` into the final
site. Without them the run fails at the Jekyll step and `output/` is left
incomplete.

An internet connection is needed for the `tx.fhir.org` terminology server. When
offline, the scripts pass `-tx n/a` automatically and the IG still builds, but
without terminology validation.

### Full build from scratch

```bash
# 1. Node dependencies (SUSHI). Uses the lockfile, does not bump versions.
npm ci

# 2. Download the IG Publisher to input-cache/publisher.jar (~240 MB).
#    Only needed the first time, or to update it.
./_updatePublisher.sh

# 3. Compile FSH -> fsh-generated/resources/ and generate the site in output/
npx fsh-sushi . && bash _genonce.sh -no-sushi
```

When it finishes:

- `output/index.html` — the generated site, opens directly in a browser.
- `qa.html` — the Publisher's validation report. **This is the file to review**:
  SUSHI can finish with 0 errors and the Publisher still find validation problems
  in the profiles and examples.

### Why `_genonce.sh` is run with `-no-sushi`

The Publisher tries to invoke `sushi` as a global executable. Here SUSHI is
installed as a local dependency, so it only exists at `node_modules/.bin/sushi`.

### Validating the FSH only (fast loop)

While editing `.fsh` files, SUSHI on its own is usually enough and takes seconds
instead of minutes. This is exactly the check CI runs:

```bash
npx fsh-sushi .
```

### Other scripts

| Script | What it does |
|---|---|
| `_updatePublisher.sh` | Downloads or updates `publisher.jar`. It also self-updates the `_*.sh` / `_*.bat` scripts themselves from the HL7 repository. |
| `_genonce.sh` | A single Publisher run. Extra arguments are passed straight through to `java -jar`. |
| `_gencontinuous.sh` | Rebuilds in a loop whenever a file changes. |
| `_build.sh` | HL7's newer script with an interactive menu, which wraps the ones above. |
