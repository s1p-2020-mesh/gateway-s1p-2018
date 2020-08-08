detach="-d"
#detach=""

docker run $detach --rm -p 8761:8761 --name eureka eureka-server
docker run $detach --rm -p 8181:8181 --name blue --env LOCALHOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=blue blueorgreenservice
docker run $detach --rm -p 7070:7070 --name green --env LOCALHOST=host.docker.internal --env SPRING_PROFILES_ACTIVE=green blueorgreenservice
docker run $detach --rm -p 9090:9090 --name frontend --env LOCALHOST=host.docker.internal blueorgreenfrontend
docker run $detach --rm  -p 8383:8383 --name gateway --env LOCALHOST=host.docker.internal blueorgreengateway