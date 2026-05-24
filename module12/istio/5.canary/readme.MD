### Deploy canary

```sh
kubectl create ns canary
kubectl label ns canary istio-injection=enabled
kubectl apply -f canary-v1.yaml -n canary
kubectl apply -f toolbox.yaml -n canary
kubectl apply -f canary-svc.yaml
```

### Access canary in toolbox

```sh
curl canary/hello
```

### Deploy the canary version

```sh
kubectl apply -f canary-v2.yaml -n canary
```

### Update istio specs

```sh
kubectl apply -f  destination.yaml
k apply -f istio-specs.yaml -n canary
```

### Check v2 canary logs and access the service with & without User header

### Access canary in toolbox

```sh
curl canary/hello -H "user: jesse"
curl canary/hello -H "user: jesse1"
```
