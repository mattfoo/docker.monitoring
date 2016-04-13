FROM debian:latest

MAINTAINER Matt Foo <foo.matt@googlemail.com>

LABEL Description="Collectd docker image, part of our monitoring suite"

ARG PROXY
ENV PROXY ${PROXY:-""}

RUN echo "Acquire::http::proxy  \"$PROXY\";" >  /etc/apt/apt.conf.d/80proxy && \
    echo "Acquire::https::proxy \"$PROXY\";" >> /etc/apt/apt.conf.d/80proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install curl supervisor collectd collectd-utils \
    && rm -rf /var/lib/apt/lists/*

ADD ./assets/packages/dumb-init_1.0.1_amd64.deb /tmp

RUN dpkg -i /tmp/dumb-init_1.0.1_amd64.deb && \
    rm /tmp/dumb-init_1.0.1_amd64.deb

ADD ./assets/build/etc/supervisord.conf /etc/supervisor/conf.d/collectd.conf
ADD ./assets/build/etc/collectd.conf    /etc/collectd/collectd.conf
ADD ./assets/build/scripts/start.sh     /usr/bin/start.sh

ENTRYPOINT [ "dumb-init", "-v", "/usr/bin/start.sh" ]
