FROM debian:latest

MAINTAINER Matt Foo <foo.matt@googlemail.com>

LABEL Description="InfluxDB docker image, part of our monitoring suite"

ARG PROXY
ENV PROXY ${PROXY:-""}

RUN echo "Acquire::http::proxy  \"$PROXY\";" >  /etc/apt/apt.conf.d/80proxy && \
    echo "Acquire::https::proxy \"$PROXY\";" >> /etc/apt/apt.conf.d/80proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install curl \
    && rm -rf /var/lib/apt/lists/*

ADD ./assets/packages/influxdb_0.11.1-1_amd64.deb /tmp
RUN dpkg -i /tmp/influxdb_0.11.1-1_amd64.deb && \
    rm /tmp/influxdb_0.11.1-1_amd64.deb

ADD ./assets/packages/dumb-init_1.0.1_amd64.deb /tmp
RUN dpkg -i /tmp/dumb-init_1.0.1_amd64.deb   && \
    rm /tmp/dumb-init_1.0.1_amd64.deb

ADD ./assets/build/etc/types.db    /usr/share/collectd/types.db
ADD ./assets/build/etc/config.toml /config/config.toml

# Admin server WebUI
EXPOSE 8083

# HTTP API
EXPOSE 8086

VOLUME ["/data"]

COPY ./assets/build/scripts/run.sh /usr/bin/run.sh

ENTRYPOINT [ "dumb-init", "-v", "/usr/bin/run.sh" ]
