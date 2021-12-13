### deploy simple
```
kubectl create ns simple
kubectl create -f simple.yaml -n simple
kubectl create -f istio-specs.yaml -n simple
```

### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   10.108.31.242
```

### access the simple via ingress
export INGRESS_IP=10.108.31.242
```
curl -H "Host: simple.cncamp.io" $INGRESS_IP/hello -v
```
