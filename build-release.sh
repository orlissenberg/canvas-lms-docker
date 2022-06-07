#!/usr/bin/env bash

# ./build-release.sh stable/2022-06-08
# docker run --rm -ti canvas-lms-node:2022-06-08 /bin/bash

RELEASE="${1:-master}"
TAG=$(echo "${1:-latest}" | sed 's/stable\///g; s/release\///g')

cd canvas-lms-node || exit
rm -rf src/"${RELEASE}" && mkdir -p src/"${RELEASE}"
git clone --depth 1 https://github.com/instructure/canvas-lms.git --single-branch --branch "${RELEASE}" src/"${RELEASE}" || exit
docker build --build-arg CANVAS_REVISION="${RELEASE}" -t canvas-lms-node:"${TAG}" .

cd ../canvas-lms-ruby || exit
docker build --build-arg TAG="${TAG}" -t canvas-lms-ruby:"${TAG}" .

cd ../canvas-lms || exit
docker build --build-arg TAG="${TAG}" -t orlissenberg/canvas-lms:"${TAG}" .

#docker push orlissenberg/canvas-lms:"${TAG}"
