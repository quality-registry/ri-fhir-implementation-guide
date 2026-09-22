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

# publisher.jar is not in the repository, so it is downloaded here with the
# project's own _updatePublisher.sh. It lands in input-cache/, where
# _genonce.sh looks for it.
#
# -y is required. Without a TTY the script's confirmation prompts read as
# empty, and it skips the download while still exiting 0; the failure would
# only surface later, in _genonce.sh. -y also refreshes the _*.sh scripts from
# HL7, which is why they are copied in before this runs.
#
# Separate layer so that editing FSH does not re-download the jar.
COPY _updatePublisher.sh _genonce.sh ./
RUN bash _updatePublisher.sh -y

# Dependencies before sources, so npm ci is cached across FSH edits.
COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts

# The build inputs, listed explicitly. Anything added at the repository root
# that the build needs must be added here too, or it will not be present.
#
# _genonce.sh is not copied again: _updatePublisher.sh above already refreshed
# it, and re-copying would revert that.
COPY sushi-config.yaml ig.ini ./
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
###############################################################################
FROM nginx:1.27-alpine AS serve

LABEL org.opencontainers.image.title="RESQ Stroke Registry Implementation Guide" \
      org.opencontainers.image.description="Static FHIR IG site served by nginx"

COPY docker/nginx.conf /etc/nginx/nginx.conf

# Arrives owned by root at 555/444 from the build stage. Combined with USER
# nginx below, the server cannot modify the content it serves, with or without
# the --read-only runtime flag.
COPY --from=build /ig/output /usr/share/nginx/html

USER nginx

# The stock /docker-entrypoint.sh rewrites files under /etc/nginx on startup,
# which fails on a read-only root filesystem. Start nginx directly instead.
ENTRYPOINT ["nginx", "-g", "daemon off;"]
