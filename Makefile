MAKEFLAGS = -s

VERSION ?= ${VERSION:-0.0.1}
NAME ?= ${NAME:-example}
IMAGE = ${NAME}:${VERSION}

SRC = `pwd`/result

# env in docker
DEST = /tars
TAR_NAME = ${NAME}-${VERSION}.tar.gz

build_docker_image:
	echo ${NAME}
	echo ${VERSION}
	echo ${IMAGE}
	docker build --build-arg NAME=${NAME} --build-arg VERSION=${VERSION} -f ./Dockerfile -t ${IMAGE} .

make_tar_in_docker:
	docker run --rm -v ${SRC}:${DEST} -e NAME=${NAME} -e VERSION=${VERSION} ${IMAGE} bash -c "copy tar"

copy:
	rm -rf /result
	mkdir -p /result
	cp /go/bin/app /result/app
	cp /app/compiled/index.html /result/app/compiled/index.html

tar:
	tar -czvf dsp.tar.gz -C /result .
	rm -rf /result
