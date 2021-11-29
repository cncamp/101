### deploy httpserver
```
kubectl create ns canary
kubectl label ns canary istio-injection=enabled
kubectl apply -f httpserver.yaml -n canary
kubectl apply -f toolbox.yaml -n canary
```
###
```
curl httpserver/hello
```
### deploy the canary version
```
kubectl apply -f httpserver-v2.yaml -n canary
```
### update istio specs
```
k apply -f istio-specs.yaml -n canary
```
### check v2 httpserver logs and access the service with & without User header
```
curl httpserver/hello -H "user: jesse"
```

