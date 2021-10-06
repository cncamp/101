### create authservice
```
kubectl create -f specs/webhook.yaml
```
### create webhook config
```
kubectl create configmap -n kube-system webhook-config --from-file=webhook-config.json
```
### update apiserver configuration to enable
```
cp /etc/kubernetes/manifests/kube-apiserver.yaml ~/kube-apiserver.yaml
cp specs/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```

