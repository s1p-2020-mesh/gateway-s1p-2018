#!/bin/bash

declare -a apps=("eureka-server"
                "blueorgreenservice"
                "blueorgreenfrontend"
                "blueorgreengateway"
                "authgateway"
                )

for app in "${apps[@]}"
do
   cd $app
   mvn clean compile com.google.cloud.tools:jib-maven-plugin:2.5.0:dockerBuild -Djib.to.image=$app:latest -Djib.from.image=gcr.io/distroless/java:11
   cd ..
done
