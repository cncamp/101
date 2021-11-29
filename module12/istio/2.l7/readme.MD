```
kubectl apply -f nginx.yaml -n httpserver
kubectl apply -f istio-specs.yaml
curl -H "Host: httpserver.cncamp.io" 10.105.227.152/httpserver/healthz
curl -H "Host: httpserver.cncamp.io" 10.105.227.152/nginx
```
