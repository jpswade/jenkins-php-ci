#!/usr/bin/env bash
docker-machine ip || docker-machine start
eval $(docker-machine env)
mkdir -p .jenkins
docker run -p 8080:8080 -v ${PWD}/.jenkins:/root/.jenkins jenkins-php-ci