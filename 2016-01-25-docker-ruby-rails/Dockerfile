FROM ruby:2.2.3

RUN \
    apt-get update -y && \
    apt-get install -y \
        build-essential \
        libpq-dev
RUN \
    useradd --home-dir /srv/app/ --shell /usr/sbin/nologin app && \
    mkdir \
        /srv/app.bundle/ \
        /srv/app/ && \
    chown -R app \
        /srv/app.bundle/ \
        /srv/app/

COPY [ \
    "Gemfile", \
    "Gemfile.lock", \
    "/srv/app/"]

USER app

WORKDIR /srv/app/
ENV BUNDLE_APP_CONFIG /srv/app.bundle/
RUN bundle install --path /srv/app.bundle/
