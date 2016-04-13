#!/bin/bash

sed -i 's,INFLUXDB_HOST,'${INFLUXDB_HOST:-"influxdb"}',' /etc/collectd/collectd.conf
sed -i 's,INFLUXDB_PORT,'${INFLUXDB_PORT:-"25826"}','    /etc/collectd/collectd.conf

sed -i 's,BOX_IP,'${BOX_IP:-"127.0.0.1"}','                      /etc/collectd/collectd.conf
sed -i 's,BOX_SNMP_VERSION,'${BOX_SNMP_VERSION:-"2"}','          /etc/collectd/collectd.conf
sed -i 's,BOX_SNMP_COMMUNITY,'${BOX_SNMP_COMMUNITY:-"public"}',' /etc/collectd/collectd.conf
sed -i 's,BOX_SNMP_INTERVAL,'${BOX_SNMP_INTERVAL:-"60"}','       /etc/collectd/collectd.conf

# Start server
supervisord -n -c /etc/supervisor/conf.d/collectd.conf
