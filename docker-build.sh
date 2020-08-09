registry=ciberkleid

declare -a dirs=("eureka-server"
                "blueorgreenservice"
                "blueorgreenfrontend"
                "blueorgreengateway"
                )

for dir in "${dirs[@]}"
do
   cd $dir
#   ./mvnw clean
   ./mvnw clean package -DskipTests
   cp ../Dockerfile .
   if [[ $dir = "eureka-server" ]]; then
     docker build . -t $dir --build-arg JAVA_VERSION=11
   else
     docker build . -t $dir --build-arg JAVA_VERSION=8
   fi
   rm Dockerfile
   docker tag $dir $registry/s1p-2020-mesh-$dir
   docker push $registry/s1p-2020-mesh-$dir
   cd ..
done
