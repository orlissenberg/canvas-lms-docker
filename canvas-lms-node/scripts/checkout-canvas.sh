#!/usr/bin/env bash

set -e

export REVISION="${REVISION:=master}"

mkdir -p /opt/canvas
cd /opt/canvas || exit
git clone --depth 1 https://github.com/instructure/canvas-lms.git --single-branch --branch "${REVISION}"

cd canvas-lms || exit
git checkout "${REVISION}"

yarn install --pure-lockfile
