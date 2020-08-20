#!/bin/bash

if [ "$1" == "all" ]
then

  BG_NS=blueorgreen-istio-2
  kubectl delete ns $BG_NS
  kubectl create ns $BG_NS
  kubectl label namespace $BG_NS istio-injection=enabled

  kns $BG_NS
  kubectl apply -f yaml/istio-2/

  kubectl rollout status deployment/blue
  kubectl rollout status deployment/green 
  kubectl rollout status deployment/orange
  kubectl rollout status deployment/yellow

fi

echo "basic"
for i in {1..12}; do time curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" --header "cookie: type="; echo; done

#echo "premium"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" ; echo; done
#
#echo "premium-2"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" ; echo; done
