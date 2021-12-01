```
kubectl apply -f nginx.yaml -n simple
kubectl apply -f istio-specs.yaml
curl -H "Host: simple.cncamp.io" 10.105.227.152/simple/healthz
curl -H "Host: simple.cncamp.io" 10.105.227.152/nginx
```
