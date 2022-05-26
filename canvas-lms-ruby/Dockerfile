ARG TAG=latest

FROM canvas-lms-node:$TAG
LABEL maintainer="Instructure"

WORKDIR /opt/canvas/canvas-lms

RUN ${GEM_HOME}/bin/bundle install --jobs 8
RUN COMPILE_ASSETS_NPM_INSTALL=0 $GEM_HOME/bin/bundle exec rake canvas:compile_assets_dev
