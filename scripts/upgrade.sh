#!/bin/bash

currentDir="$(cd "$(dirname $0)";pwd)"

$currentDir/pull-image.sh
docker compose restart
docker images  | grep none | awk '{print $3}' | xargs docker rmi
