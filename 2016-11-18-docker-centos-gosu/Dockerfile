FROM centos:7

ENV GOSU_VERSION 1.9
ENV GOSU_ARCH amd64
RUN set -x \
    && \
    curl -SL -o /usr/local/bin/gosu \
        "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCH" \
    && \
    curl -SL -o /usr/local/bin/gosu.asc \
        "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCH.asc" \
    && \
    export GNUPGHOME="$(mktemp -d)" \
    && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
        B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && \
    gpg --batch --verify \
        /usr/local/bin/gosu.asc \
        /usr/local/bin/gosu \
    && \
    rm -r \
        "$GNUPGHOME" \
        /usr/local/bin/gosu.asc \
    && \
    chmod +x \
        /usr/local/bin/gosu \
    && \
    gosu nobody true
