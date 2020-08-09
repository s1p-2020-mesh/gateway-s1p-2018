#!/bin/sh

kustomize edit add resource base/k8s-deployment.yaml
kustomize edit add resource base/k8s-service.yaml
kustomize edit set image ciberkleid/s1p-2020-mesh-blueorgreenservice=$1/s1p-2020-mesh-blueorgreenservice
kustomize edit set image ciberkleid/s1p-2020-mesh-authgateway=$1/s1p-2020-mesh-authgateway