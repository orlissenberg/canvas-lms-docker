#!/usr/bin/env bash

set -e

export POSTGRES_BIN=/usr/lib/postgresql/12/bin

sudo -u postgres $POSTGRES_BIN/createuser --superuser docker
sudo -u postgres $POSTGRES_BIN/createdb -E UTF-8 -T template0 --lc-collate=en_US.UTF-8 --lc-ctype=en_US.UTF-8 --owner docker canvas_${RAILS_ENV}
sudo -u postgres $POSTGRES_BIN/createdb -E UTF-8 -T template0 --lc-collate=en_US.UTF-8 --lc-ctype=en_US.UTF-8 --owner docker canvas_queue_${RAILS_ENV}

export CANVAS_LMS_ADMIN_EMAIL="docker@acme.edu"
export CANVAS_LMS_ADMIN_PASSWORD="canvas-docker"
export CANVAS_LMS_ACCOUNT_NAME="Canvas Docker"
export CANVAS_LMS_STATS_COLLECTION="opt_out"

cd /opt/canvas/canvas-lms
"${GEM_HOME}"/bin/bundle exec rake db:initial_setup

# psql -U canvas -d canvas_development -c ""
