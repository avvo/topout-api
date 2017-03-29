#!/bin/sh

set -e

APP_NAME=topout-api
GITSHA=$(git rev-parse --short HEAD)
BRANCH=$(git rev-parse --abbrev-ref HEAD)

mix docker.build
mix docker.release --build-arg SOURCE_COMMIT=$(git rev-parse HEAD)
docker tag avvo/$APP_NAME:release avvo/$APP_NAME:$BRANCH
