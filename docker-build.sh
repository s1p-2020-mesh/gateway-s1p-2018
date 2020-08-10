declare -a apps=("eureka-server"
                "blueorgreenservice"
                "blueorgreenfrontend"
                "blueorgreengateway"
                "authgateway"
                )

for app in "${apps[@]}"
do
   cd $app
   if [[ $app = "eureka-server" ]]; then JAVA_VERSION=11; else JAVA_VERSION=8; fi
   mvn clean compile com.google.cloud.tools:jib-maven-plugin:2.5.0:dockerBuild -Djib.to.image=$app:latest -Djib.from.image=gcr.io/distroless/java:$JAVA_VERSION
   cd ..
done
