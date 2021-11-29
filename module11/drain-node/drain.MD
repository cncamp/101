### evict all pods from a node
```
kubectl drain cadmin
```
### make a node scheduable again
```
kubectl cordon
kubectl uncordon
```

```
curl -v -H 'Content-type: application/json' --key admin.key --cert admin.crt https://192.168.34.2:6443/api/v1/namespaces/default/pods/nginx-deployment-9b44bf4b5-x4xc4/eviction -d @eviction.json

{
  "apiVersion": "policy/v1",
  "kind": "Eviction",
  "metadata": {
    "name": "nginx-deployment-9b44bf4b5-x4xc4",
    "namespace": "default"
  }
}
```