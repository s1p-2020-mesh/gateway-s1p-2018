#!/bin/bash

registry=marygabry1508
#gwTag="cb-NONE"
#gwTag="cb-TIMEOUT"
gwTag="cb-FALLBACK"

declare -a apps=("eureka-server"
                "blueorgreenservice"
                "blueorgreenfrontend"
                "blueorgreengateway"
                "authgateway"
                )

for app in "${apps[@]}"
do
  docker tag $app $registry/s1p-2020-mesh-$app
  docker push $registry/s1p-2020-mesh-$app
done

#for app in "${apps[@]}"
#do
#  if [[ $app = "blueorgreengateway" ]]; then
##    echo "Tagging $app as $gwTag. Continue? [yN]: "
##    read cont
#    if [ $cont = "Y" ] || [ $cont = "y" ]; then
#      docker tag $app $app:$gwTag
#      docker tag $app $registry/s1p-2020-mesh-$app:$gwTag
#      docker push $registry/s1p-2020-mesh-$app:$gwTag
#    else
#      echo "Skipping tagging as $app:$gwTag"
#    fi
#  fi
#done
