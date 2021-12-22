```sh
kubectl apply -f nginx.yaml -n simple
kubectl apply -f istio-specs.yaml -n simple
curl -H "Host: simple.cncamp.io" $INGRESS_IP/simple/hello
curl -H "Host: simple.cncamp.io" $INGRESS_IP/nginx
```
