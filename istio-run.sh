#!/bin/sh

NS=blueorgreen-istio
kubectl delete ns $NS
kubectl create ns $NS
kubectl label namespace $NS istio-injection=enabled
kubectl config set-context $(kubectl config current-context) --namespace=$NS

kubectl apply -f yaml/istio/


# for i in {1..12}; do time curl --location --request GET "http://blueorgreen.springone.coraiberkleid.xyz/blueorgreen" --header "cookie: type=premium"; echo; done