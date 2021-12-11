```
kubectl create configmap envoy-config --from-file=envoy.yaml
kubectl create -f envoy-deploy.yaml
```