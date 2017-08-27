#!/usr/bin/env bash
docker-machine ip || docker-machine start
eval $(docker-machine env)
docker build .
