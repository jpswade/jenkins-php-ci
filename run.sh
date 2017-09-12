#!/usr/bin/env bash
set -e
docker-machine ip || docker-machine start
eval $(docker-machine env)
docker stop jenkins-php-ci
docker rm jenkins-php-ci
docker run -p 8080:8080 --name jenkins-php-ci -d jenkins-php-ci
#docker exec -it jenkins-php-ci bash