#!/bin/bash
APP_NAME=topout-api
VERSION=${1:-latest}
GITSHA=`git rev-parse --short HEAD`

docker push avvo/$APP_NAME:$GITSHA
docker push avvo/$APP_NAME:$VERSION
