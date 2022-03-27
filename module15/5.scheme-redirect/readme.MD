### Apply gateway with tls redirect setting

```sh
kubectl apply -f https-gateway.yaml
```

### Access gateway via http port

```sh
curl 10.109.127.136/productpage -v -L -k
```
