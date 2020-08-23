#!/bin/bash

if [ "$1" == "all" ]
then

  BG_NS=blueorgreen-istio
  kubectl delete ns $BG_NS
  kubectl create ns $BG_NS
  kubectl label namespace $BG_NS istio-injection=enabled

  kns $BG_NS
  kubectl apply -f yaml/

  kubectl rollout status deployment/blue
  kubectl rollout status deployment/green 
  kubectl rollout status deployment/yellow

fi

echo "basic"
for i in {1..12}; do time curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" --header "cookie: type="; echo; done

#echo "premium"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" ; echo; done
#
#echo "premium-2"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" ; echo; done
#
#echo "basic"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" --header 'cookie: type=none'; echo; done
#
#echo "premium"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" --header 'cookie: type=premium'; echo; done
#
#echo "premium-2"
#for i in {1..6}; do curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" --header 'cookie: type=premium; SESSION=b325b3e0-4607-422c-9de5-e0be75aa088c'; echo; done
