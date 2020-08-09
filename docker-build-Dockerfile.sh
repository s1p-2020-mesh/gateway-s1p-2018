registry=ciberkleid
#gwTag="cb-NONE"
#gwTag="cb-TIMEOUT"
gwTag="cb-FALLBACK"

declare -a dirs=("eureka-server"
                "blueorgreenservice"
                "blueorgreenfrontend"
                "blueorgreengateway"
                "authgateway"
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
   if [[ $dir = "blueorgreengateway" ]]; then
     echo "About to tag gateway as $gwTag. Continue? [yN]: "
     read cont
     if [ $cont = "Y" ] || [ $cont = "y" ]; then
       docker tag $dir $dir:$gwTag
       docker tag $dir $registry/s1p-2020-mesh-$dir:$gwTag
       docker push $registry/s1p-2020-mesh-$dir:$gwTag
    else
      echo "Skipping tagging as $dir:$gwTag"
    fi
   fi
   cd ..
done
