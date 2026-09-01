# RES-Q FHIR Implementation Guide

This is the repository of the RES-Q FHIR Implementation Guide.

## Published site

The Implementation Guide is published automatically at:
- **Custom URL**: https://www.tecnomod-um.org
- **GitHub Pages URL**: https://tecnomod-um.github.io/RESQFHIR-IG

## DNS configuration

For information about setting up the custom domain, see [DNS_SETUP.md](DNS_SETUP.md).

## Development

This IG uses SUSHI to compile the FSH resources and the HL7 FHIR IG Publisher to generate the website.

### Prerequisites

| Tool | Minimum version | Check with |
|---|---|---|
| Java (JDK) | 17 | `java -version` |
| Node.js | 18 | `node -v` |
| curl | any | `curl --version` |

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
