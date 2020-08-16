#!/bin/bash

if [ "$1" == "all" ]
then
kubectl delete -f yaml/istio/
kubectl apply -f yaml/istio/
kubectl rollout status deployment/yellow
fi

echo "basic"
for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" --header 'cookie: type=none'; echo; done

echo "premium"
for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" --header 'cookie: type=premium'; echo; done

echo "premium-2"
for i in {1..6}; do curl --location --request GET "http://blueorgreen.marygabry.name/blueorgreen" --header 'cookie: type=premium; SESSION=b325b3e0-4607-422c-9de5-e0be75aa088c'; echo; done
