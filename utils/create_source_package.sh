#!/bin/bash
version=$1
out=${2:-"copyq-${version}.tar.gz"}

set -e

die () {
    echo "ERROR: $*"
    exit 1
}

grep -q '^v'"$version"'$' CHANGES ||
    die "CHANGES file doesn't contain changes for given version!"

git archive --format=tar.gz --prefix="copyq-$version/" --output="$out" "v$version" ||
    die "First arguments must be existing version (tag v<VERSION> must exist in repository)!"

echo "Created source package for version $version: $out"

size=$(stat --format="%s" "$out")
hash=$(md5sum "$out" | cut -d' ' -f 1)
echo " $hash $size $out"

