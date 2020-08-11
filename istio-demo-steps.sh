#!/bin/bash

# Config
if [[ -f $PWD/kubeconfig-cinquecento.yml ]]; then
    export KUBECONFIG=$PWD/kubeconfig-cinquecento.yml
else
    export KUBECONFIG=~/Downloads/kubeconfig-cinquecento.yml
fi
export BG_NS=blueorgreen-istio
export INGRESS_DOMAIN=blueorgreen.marygabry.name

# Install Istio
# To enable privileged containers for a service account, you can use the following command:
#kubectl create rolebinding privileged-role-binding --clusterrole=vmware-system-tmc-psp-privileged --user=system:serviceaccount:<namespace>:<service-account>
# OR to enable privileged containers for the entire cluster, you can use the following command:
kubectl create clusterrolebinding privileged-cluster-role-binding --clusterrole=vmware-system-tmc-psp-privileged --group=system:authenticated
curl -L https://istio.io/downloadIstio | sh -
REL=$(curl -L -s https://api.github.com/repos/istio/istio/releases | \
                  grep tag_name | sed "s/ *\"tag_name\": *\"\\(.*\\)\",*/\\1/" | \
                  grep -v -E "(alpha|beta|rc)\.[0-9]$" | sort -t"." -k 1,1 -k 2,2 -k 3,3 -k 4,4 | tail -n 1)
export PATH=$PWD/istio-$REL/bin:$PATH
istioctl install --set profile=demo --set meshConfig.accessLogFile="/dev/stdout"

# Set up Kiali dashboard
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http-kiali
      protocol: HTTP
    hosts:
    - "kiali.blueorgreen.marygabry.name"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali-vs
  namespace: istio-system
spec:
  hosts:
  - "kiali.blueorgreen.marygabry.name"
  gateways:
  - kiali-gateway
  http:
  - route:
    - destination:
        host: kiali
        port:
          number: 20001
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: kiali
  namespace: istio-system
spec:
  host: kiali
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF

# Install bluegreen demo
kubectl create ns $BG_NS
kubectl label namespace $BG_NS istio-injection=enabled
istioctl analyze -n $BG_NS
kubectl -n $BG_NS apply -f yaml/istio/

# Get Istio Ingress Host
echo "istio-ingressgateway hostname:"
kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'