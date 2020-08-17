#!/bin/bash

detach="-d"
#detach=""

docker run $detach --rm -p 8761:8761 --name eureka eureka-server
docker run $detach --rm -p 8181:8181 --name blue --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=blue blueorgreenservice
docker run $detach --rm -p 7070:7070 --name green --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=green blueorgreenservice
docker run $detach --rm -p 9090:9090 --name frontend --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal blueorgreenfrontend
docker run $detach --rm  -p 8383:8383 --name gateway --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal blueorgreengateway

# circuit breaker demo
docker run $detach --rm -p 6060:6060 --name slowgreen --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=slowgreen blueorgreenservice

# premium (TODO: REDIRECT FROM AUTHGATEWAY TO GATEWAY FAILING: Connection refused: host.docker.internal/192.168.65.2:8383)
docker run $detach --rm -p 8282:8282 --name yellow --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=yellow blueorgreenservice
docker run $detach --rm  -p 8080:8080 --name authgateway --env EUREKA_HOST=host.docker.internal --env EUREKA_CLIENT_HOST=host.docker.internal authgateway

###
# To demo without auth, go to frontend directly: http://localhost:9090
# To demo with auth (premium), go to authgateway and login as "user" or "premium" and password "pw": http://localhost:8080
