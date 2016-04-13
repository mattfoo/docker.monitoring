#!/bin/bash

: "${GF_PATHS_DATA:=/var/lib/grafana}"
: "${GF_PATHS_LOGS:=/var/log/grafana}"

if [ "${GF_SERVER_PROTOCOL}" == "https" ]; then
    echo "[INFO] HTTPS enabled..."
    if [ ! -f /etc/grafana/ssl/cert.pem ] && [ ! -f /etc/grafana/ssl/key.pem ]; then
        mkdir -p /etc/grafana/ssl && chmod 750 /etc/grafana/ssl
        openssl req -x509 -newkey rsa:2048 -keyout /etc/grafana/ssl/key.pem \
                -out /etc/grafana/ssl/cert.pem -days ${VALIDITY} -subj "${DNAME}" -nodes
        chmod 0640 /etc/grafana/ssl/*.pem
    fi
else
    echo "[WARNING] HTTPS disabled..."
fi

chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS"
chown -R grafana:grafana /etc/grafana

exec gosu grafana /usr/sbin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data="$GF_PATHS_DATA"   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"
