ARG RUBY=2.7
FROM canvas-lms-ruby:latest as build

WORKDIR /opt/canvas/canvas-lms

RUN rm -rf node_modules

FROM instructure/ruby-passenger:$RUBY
LABEL maintainer="Instructure"

ARG POSTGRES_CLIENT=12
ENV APP_HOME /usr/src/app/
ENV RAILS_ENV development
ENV NGINX_MAX_UPLOAD_SIZE 10g
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ARG CANVAS_RAILS=6.0
ENV CANVAS_RAILS=${CANVAS_RAILS}

ENV BUNDLER_VERSION 2.2.17
ENV GEM_HOME /home/docker/.gem/$RUBY
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_APP_CONFIG /home/docker/.bundle

WORKDIR $APP_HOME

USER root

ARG USER_ID
# This step allows docker to write files to a host-mounted volume with the correct user permissions.
# Without it, some linux distributions are unable to write at all to the host mounted volume.
RUN if [ -n "$USER_ID" ]; then usermod -u "${USER_ID}" docker \
        && chown --from=9999 docker /usr/src/nginx /usr/src/app -R; fi

RUN printf 'path-exclude /usr/share/doc/*\npath-exclude /usr/share/man/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get update -qq \
  && apt-get install -qqy --no-install-recommends \
       libxmlsec1-dev \
       python-lxml \
       python3-lxml \
       libicu-dev \
       parallel \
       postgresql-client-$POSTGRES_CLIENT \
       unzip \
       pbzip2 \
       fontforge \
       build-essential \
       python2 \
       python-is-python2 \
       redis-server \
       postgresql-12 \
       supervisor

RUN if [ -e /var/lib/gems/$RUBY_MAJOR.0/gems/bundler-* ]; then BUNDLER_INSTALL="-i /var/lib/gems/$RUBY_MAJOR.0"; fi \
  && gem uninstall --all --ignore-dependencies --force $BUNDLER_INSTALL bundler \
  && gem install bundler --no-document -v $BUNDLER_VERSION \
  && find $GEM_HOME ! -user docker | xargs chown docker:docker

COPY --from=build /opt/canvas/ /opt/canvas/
COPY --from=build /home/docker/.gem/ /home/docker/.gem/

WORKDIR /opt/canvas/canvas-lms

COPY scripts/ /
RUN chmod 755 /*.sh

COPY etc/ /etc/

COPY config/ /opt/canvas/canvas-lms/config/
RUN /configure-canvas.sh \
  && mkdir -p /tmp/attachment_fu/ \
  && chown -R docker: /tmp/attachment_fu/

RUN sed -i "/^#listen_addresses/i listen_addresses='*'" /etc/postgresql/12/main/postgresql.conf \
  && service postgresql start  \
  && /database-init.sh

RUN chown -R docker: /opt/canvas

# Clean
RUN rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && rm -rf /var/cache/apt

# postgres
EXPOSE 5432
# redis
EXPOSE 6379
# canvas
EXPOSE 3000

CMD ["/start.sh"]
