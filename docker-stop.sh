#!/bin/bash

docker stop eureka
docker stop blue
docker stop green
docker stop frontend
docker stop gateway

# circuit breaker demo
docker stop slowgreen

# premium
docker stop yellow
docker stop authgateway