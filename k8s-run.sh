#!/bin/sh

NS=blueorgreen-eureka
kubectl delete ns $NS
kubectl create ns $NS
kubectl config set-context $(kubectl config current-context) --namespace=$NS

kubectl apply -f yaml/eureka/