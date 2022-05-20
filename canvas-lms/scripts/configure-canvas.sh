#!/usr/bin/env bash

cd /opt/canvas/canvas-lms || exit

for config in amazon_s3 delayed_jobs domain file_store security external_migration; do
  cp config/$config.yml.example config/$config.yml
done

mkdir -p log tmp/pids public/assets public/stylesheets/compiled
touch Gemmfile.lock
