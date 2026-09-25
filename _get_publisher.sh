#!/bin/bash
# Downloads a specific IG Publisher release to input-cache/publisher.jar, where
# _genonce.sh looks for it.
#
# Usage: ./_get_publisher.sh <version> [sha256]
#
#   version  Release tag, e.g. 2.3.4
#   sha256   Expected SHA-256 of publisher.jar. When given, the download is
#            verified and discarded on mismatch. When omitted, it is not
#            verified; the container build always passes it.
#
# The digest for a release is listed by:
#   curl -sL https://api.github.com/repos/HL7/fhir-ig-publisher/releases/tags/<version> \
#     | grep -A2 '"name": "publisher.jar"'
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ] || [ -z "$1" ]; then
	echo "Usage: $0 <version> [sha256]" >&2
	exit 1
fi

version=$1
sha256=${2:-}
url="https://github.com/HL7/fhir-ig-publisher/releases/download/${version}/publisher.jar"
target=input-cache/publisher.jar

mkdir -p input-cache
# Download next to the target and only move it into place once verified, so a
# failed check never leaves a jar behind for _genonce.sh to pick up.
tmp=$(mktemp input-cache/publisher.jar.XXXXXX)
trap 'rm -f "$tmp"' EXIT

echo "Downloading IG Publisher $version"
curl -fSL -o "$tmp" "$url"

if [ -n "$sha256" ]; then
	if command -v sha256sum > /dev/null; then
		actual=$(sha256sum "$tmp" | cut -d' ' -f1)
	else
		actual=$(shasum -a 256 "$tmp" | cut -d' ' -f1)
	fi
	if [ "$actual" != "$sha256" ]; then
		echo "Checksum mismatch for publisher.jar $version" >&2
		echo "  expected: $sha256" >&2
		echo "  actual:   $actual" >&2
		exit 1
	fi
	echo "Checksum OK"
else
	echo "WARNING: no checksum given, publisher.jar was not verified" >&2
fi

# mktemp creates the file as 0600; give the jar normal read permissions.
chmod 644 "$tmp"
mv "$tmp" "$target"
trap - EXIT
echo "Saved to $target"
