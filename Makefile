all: build

build:
	@docker build .

push:
	@docker push credija/openfire:$(shell cat VERSION)
