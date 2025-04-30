#!/bin/bash

RELEASE=${1:-latest}

docker pull docker.io/onesb/otel-lgtm:"${RELEASE}"

touch .env

mkdir -vp container/grafana container/prometheus container/loki

docker run \
	--name lgtm \
	-p 3001:3000 \
	-p 4317:4317 \
	-p 4318:4318 \
        -p 8126:8126 \
	--rm \
	-d \
	-v "$PWD"/container/grafana:/data/grafana \
	-v "$PWD"/container/prometheus:/data/prometheus \
	-v "$PWD"/container/loki:/data/loki \
	-e GF_PATHS_DATA=/data/grafana \
	--env-file .env \
	docker.io/onesb/otel-lgtm:"${RELEASE}"
