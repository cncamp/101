### apply gateway with tls redirect setting
```
kubectl apply -f https-gateway.yaml
```
access gateway via http port
```
curl 10.109.127.136/productpage -v -L -k
```
