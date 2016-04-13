FROM debian:latest

MAINTAINER Matt Foo <foo.matt@googlemail.com>

LABEL Description="Grafana docker image, part of our monitoring suite"

ARG PROXY
ENV PROXY ${PROXY:-""}

RUN echo "Acquire::http::proxy  \"$PROXY\";" >  /etc/apt/apt.conf.d/80proxy && \
    echo "Acquire::https::proxy \"$PROXY\";" >> /etc/apt/apt.conf.d/80proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install libfontconfig curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ADD ./assets/packages/gosu-amd64 /usr/sbin/gosu

ADD ./assets/packages/grafana_2.6.0_amd64.deb /tmp
RUN dpkg -i /tmp/grafana_2.6.0_amd64.deb   && \
    rm /tmp/grafana_2.6.0_amd64.deb

ADD ./assets/packages/dumb-init_1.0.1_amd64.deb /tmp
RUN dpkg -i /tmp/dumb-init_1.0.1_amd64.deb && \
    rm /tmp/dumb-init_1.0.1_amd64.deb

VOLUME [ "/var/lib/grafana", "/var/log/grafana", "/etc/grafana" ]

EXPOSE 3000

COPY ./assets/build/scripts/run.sh /usr/bin/run.sh

ENTRYPOINT [ "dumb-init", "-v", "/usr/bin/run.sh" ]
