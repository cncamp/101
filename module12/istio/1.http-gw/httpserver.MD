### deploy simple
```
kubectl create ns simple
kubectl create -f simple.yaml -n simple
kubectl create -f istio-specs.yaml -n simple
```

### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   10.105.227.152
```

### access the simple via ingress
```
curl -H "Host: simple.cncamp.io" 10.105.227.152/hello -v
```
