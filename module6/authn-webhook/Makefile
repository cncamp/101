export tag=v1.0
root:
	export ROOT=github.com/cncamp/authn-webhook

build:
	echo "building authn-webhook binary"
	mkdir -p bin/amd64
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/amd64 .

release: build
	echo "building authn-webhook container"
	docker build -t cncamp/authn-webhook:${tag} .

push: release
	echo "pushing cncamp/authn-webhook"
	docker push cncamp/authn-webhook:${tag}
