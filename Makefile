.PHONY: collectd grafana influxdb clean

all: collectd grafana influxdb

collectd:
	$(MAKE) -C ./collectd

grafana:
	$(MAKE) -C ./grafana

influxdb:
	$(MAKE) -C ./influxdb

html: README.md
	@pandoc -s -S --toc -c pandoc.css -f markdown README.md -t html5 -o ./doc/README.html

clean:
	$(MAKE) -C ./collectd clean
	$(MAKE) -C ./grafana  clean
	$(MAKE) -C ./influxdb clean
	rm -f ./doc/README.html

default: collectd grafana influxdb
