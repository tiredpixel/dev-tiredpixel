FROM python:3.4.3

RUN \
    useradd --home-dir /srv/site/ --shell /usr/sbin/nologin site && \
    mkdir -p \
        /srv/site/ \
        /srv/site.dep/ && \
    chown -R site \
        /srv/site/ \
        /srv/site.dep/

RUN pip install virtualenv

COPY [ \
    "requirements.txt", \
    "/srv/site/"]

USER site

WORKDIR /srv/site/
RUN virtualenv /srv/site.dep/virtualenv/
ENV PATH /srv/site.dep/virtualenv/bin:$PATH
RUN pip install --cache-dir /srv/site.dep/pip-cache/ \
    --requirement requirements.txt
