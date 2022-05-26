#!/usr/bin/env bash

# ./build-release.sh release/2022-06-08.135
# docker run --rm -ti canvas-lms-node:2022-06-08.135 /bin/bash

RELEASE="${1:-master}"
TAG="${1:-latest}"

cd canvas-lms-node || exit
docker build --build-arg CANVAS_REVISION="${RELEASE}" -t canvas-lms-node:"${TAG#release/}" .

cd ../canvas-lms-ruby || exit
docker build --build-arg TAG="${TAG#release/}" -t canvas-lms-ruby:"${TAG#release/}" .

cd ../canvas-lms || exit
docker build --build-arg TAG="${TAG#release/}" -t orlissenberg/canvas-lms:"${TAG#release/}" .

#docker push orlissenberg/canvas-lms:"${TAG#release/}"
