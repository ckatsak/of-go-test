.PHONY: all build scratch build-scratch run-scratch alpine build-alpine \
	run-alpine clean

all: build

build: build-scratch build-alpine
	docker image prune -f

scratch: build-scratch run-scratch
alpine:  build-alpine  run-alpine

run-scratch:
	-docker run -it --rm -p 8080:8080 ckatsak/of-go-test:v0.1.0-scratch
run-alpine:
	-docker run -it --rm -p 8080:8080 ckatsak/of-go-test:v0.1.0-alpine3.12

build-scratch:
	docker build --no-cache -f scratch/Dockerfile \
		-t ckatsak/of-go-test:v0.1.0-scratch .
build-alpine:
	docker build --no-cache -f alpine/Dockerfile \
		-t ckatsak/of-go-test:v0.1.0-alpine3.12 .

clean:
	-docker rmi ckatsak/of-go-test:v0.1.0-scratch \
		ckatsak/of-go-test:v0.1.0-alpine3.12
	docker image prune -f
