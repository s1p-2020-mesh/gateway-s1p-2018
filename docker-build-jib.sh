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
   if [[ $dir = "eureka-server" ]]; then
     JAVA_VERSION=11
   else
     JAVA_VERSION=8
   fi
   mvn clean compile com.google.cloud.tools:jib-maven-plugin:2.5.0:dockerBuild -Djib.to.image=$dir:latest -Djib.from.image=gcr.io/distroless/java:$JAVA_VERSION
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
