### deploy httpserver
```
kubectl create ns httpserver
kubectl create -f httpserver.yaml -n httpserver
```
### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   10.105.227.152
```
### access the httpserver via ingress
```
curl -H "Host: httpserver.cncamp.io" 10.105.227.152/hello -v
```
