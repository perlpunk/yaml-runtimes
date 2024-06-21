#!/bin/sh

set -x

cd /tmp
cp $SOURCE .
tar xvf $VERSION.tar.gz
cd js-yaml-$VERSION
perl -pi -e 's/"istanbul": "\^0\.4\.5",/"istanbul-classic": "^2019.8.9",/' package.json
npm install .
npm pack > pack.filename
filename=$PWD/"$(cat pack.filename)"

# workaround:
# npm install creates a new node_modules directory
cd /tmp
npm install --no-save $filename

mkdir -p /build/node
rsync -a node_modules /build/node/
