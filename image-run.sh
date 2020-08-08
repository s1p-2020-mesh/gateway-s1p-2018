detach="-d"
#detach=""

docker run $detach --rm --name eureka -p 8761:8761 eureka-server
docker run $detach --rm --name blue -p 8181:8181 --env SPRING_PROFILES_ACTIVE=blue blueorgreenservice
docker run $detach --rm --name green -p 7070:7070 --env SPRING_PROFILES_ACTIVE=green blueorgreenservice
docker run $detach --rm --name frontend -p 8761:8761 blueorgreenfrontend
docker run $detach --rm --name gateway -p 8761:8761 blueorgreengateway