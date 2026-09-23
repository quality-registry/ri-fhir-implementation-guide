# syntax=docker/dockerfile:1.7

###############################################################################
# Stage 1 - build the IG: FSH -> FHIR resources -> static site in output/.
###############################################################################
FROM eclipse-temurin:17-jdk-jammy AS build

ARG NODE_MAJOR=20
ENV DEBIAN_FRONTEND=noninteractive

# Ruby and Jekyll are required, not optional: the IG Publisher shells out to
# jekyll to render the narrative pages in input/pagecontent/.
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates git ruby-full build-essential zlib1g-dev \
 && curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && gem install --no-document jekyll \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /ig

# publisher.jar is not in the repository, so it is downloaded here. The version
# is pinned and the download is checksum-verified: the build must run a known
# artifact, never whatever "latest" happens to resolve to at build time.
#
# To upgrade, bump both values together. The digest for a release is shown by:
#   curl -sL https://api.github.com/repos/HL7/fhir-ig-publisher/releases/tags/<version> \
#     | grep -A2 '"name": "publisher.jar"'
#
# _updatePublisher.sh is deliberately not used here: it can only fetch the
# latest release, and it also overwrites the _*.sh scripts from a moving branch
# and then runs them. Both are unpinned code paths.
#
# Separate layer so that editing FSH does not re-download the jar.
ARG IG_PUBLISHER_VERSION=2.3.4
ARG IG_PUBLISHER_SHA256=970922c12eb583bfb4cb6121584b922a236d5904e36413e3545d2fbc248f8e2b
RUN mkdir -p input-cache \
 && curl -fSL -o input-cache/publisher.jar \
      "https://github.com/HL7/fhir-ig-publisher/releases/download/${IG_PUBLISHER_VERSION}/publisher.jar" \
 && echo "${IG_PUBLISHER_SHA256}  input-cache/publisher.jar" | sha256sum -c -

# Dependencies before sources, so npm ci is cached across FSH edits.
COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts

# The build inputs, listed explicitly. Anything added at the repository root
# that the build needs must be added here too, or it will not be present.
# _genonce.sh is the repository's own copy, under version control and reviewable
# in diffs, rather than one fetched at build time.
COPY sushi-config.yaml ig.ini _genonce.sh ./
COPY input/ ./input/

# -no-sushi because the Publisher expects a global `sushi` executable, while
# this project installs it locally at node_modules/.bin/sushi.
#
# Permissions are applied here rather than in the serve stage: a chmod -R there
# would rewrite every file and add a second full copy of the site as another
# layer, roughly doubling the image. COPY --from preserves mode and ownership.
RUN npx fsh-sushi . --log-level info \
 && bash _genonce.sh -no-sushi \
 && chown -R root:root output \
 && find output -type d -exec chmod 555 {} + \
 && find output -type f -exec chmod 444 {} +

###############################################################################
# Stage 2 - serve. Only output/ crosses over; the JDK, Ruby, Node and the
# publisher jar stay behind in the build stage.
#
# Chainguard nginx is distroless: no shell, no package manager, no curl. That
# rules out RUN steps here, which is why file ownership and modes are applied
# in the build stage above. It runs as non-root uid 65532 and starts nginx
# directly, so no entrypoint override is needed.
#
# The tag is deliberately :latest. Chainguard rebuilds these images for CVE
# patches and does not retain older digests on the free tier, so pinning by
# digest would freeze security updates and eventually break the build.
###############################################################################
FROM cgr.dev/chainguard/nginx:latest AS serve

LABEL org.opencontainers.image.title="RESQ Stroke Registry Implementation Guide" \
      org.opencontainers.image.description="Static FHIR IG site served by nginx"

# Replaces the stock config, which logs to files under /var/log/nginx and puts
# the pid in /run. docker/nginx.conf keeps every writable path in /tmp.
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Owned by root at 555/444 from the build stage, world-readable, so uid 65532
# can serve it but nothing in the container can modify it.
COPY --from=build /ig/output /usr/share/nginx/html

USER 65532
