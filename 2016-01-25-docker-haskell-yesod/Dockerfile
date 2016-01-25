FROM haskell:7.10.2

RUN \
    apt-get update -y && \
    apt-get install -y \
        libpq-dev
RUN \
    useradd --create-home --shell /usr/sbin/nologin app && \
    mkdir -p \
        /srv/app/ \
        /srv/app.cabal/ && \
    chown -R app \
        /srv/app/ \
        /srv/app.cabal/

COPY [ \
    "app.cabal", \
    "/srv/app/"]

USER app

WORKDIR /srv/app.cabal/
RUN \
    cabal update && \
    cabal sandbox init --sandbox /srv/app.cabal/sandbox/
ENV CABAL_SANDBOX_CONFIG /srv/app.cabal/cabal.sandbox.config
ENV PATH /srv/app.cabal/sandbox/bin:$PATH

WORKDIR /srv/app/
RUN \
    cabal install -j --only-dependencies --flags "dev library-only" && \
    cabal install -j yesod-bin
