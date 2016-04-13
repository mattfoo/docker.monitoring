DOCKERFILE = Dockerfile
NAME       = monitor.grafana
PROXY	   =
VERSION    = 2.6.0

.PHONY: build clean

all: build html

build:
	@docker build --build-arg PROXY=$(PROXY) --rm=true -t $(NAME):$(VERSION) -f $(DOCKERFILE) .
	@docker tag $(NAME):$(VERSION) $(NAME):latest
	@docker images $(NAME):$(VERSION)

html: README.md
	@pandoc -s -S --toc -c pandoc.css -f markdown README.md -t html5 -o ./doc/README.html

clean:
	@docker rmi $(NAME):latest
	@docker rmi $(NAME):$(VERSION)
	rm -f ./doc/README.html

default: build
