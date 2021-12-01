### deploy canary
```
kubectl create ns canary
kubectl label ns canary istio-injection=enabled
kubectl apply -f canary.yaml -n canary
kubectl apply -f toolbox.yaml -n canary
```
### access canary in toolbox
```
curl canary/hello
```
### deploy the canary version
```
kubectl apply -f canary-v2.yaml -n canary
```
### update istio specs
```
k apply -f istio-specs.yaml -n canary
```
### check v2 canary logs and access the service with & without User header
### access canary in toolbox
```
curl canary/hello -H "user: jesse"
```

