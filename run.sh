#!/usr/bin/env bash
docker-machine ip || docker-machine start
eval $(docker-machine env)
docker run -p 8080:8080 -v /var/jenkins_home jenkins-php-ci