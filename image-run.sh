detach="-d"
#detach=""

docker run $detach --rm -p 8761:8761 --name eureka eureka-server
docker run $detach --rm -p 8181:8181 --name blue --env SERVICE_URL_DEFAULT_ZONE=host.docker.internal --env SPRING_PROFILES_ACTIVE=blue blueorgreenservice
docker run $detach --rm -p 7070:7070 --name green --env SERVICE_URL_DEFAULT_ZONE=host.docker.internal --env SPRING_PROFILES_ACTIVE=green blueorgreenservice
docker run $detach --rm -p 9090:9090 --name frontend --env SERVICE_URL_DEFAULT_ZONE=host.docker.internal blueorgreenfrontend
docker run $detach --rm  -p 8383:8383 --name gateway --env SERVICE_URL_DEFAULT_ZONE=host.docker.internal blueorgreengateway