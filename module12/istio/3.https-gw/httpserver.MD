### deploy httpserver
```
kubectl create ns httpsserver
kubectl label ns httpsserver istio-injection=enabled
kubectl create -f httpserver.yaml -n httpsserver
```
```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=cncamp Inc./CN=*.cncamp.io' -keyout cncamp.io.key -out cncamp.io.crt
kubectl create -n istio-system secret tls cncamp-credential --key=cncamp.io.key --cert=cncamp.io.crt
kubectl create -f istio-specs.yaml -n httpsserver
```

### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   10.105.227.152
```
### access the httpserver via ingress
```
curl --resolve httpsserver.cncamp.io:443:10.105.227.152 https://httpsserver.cncamp.io/healthz -v -k
```
