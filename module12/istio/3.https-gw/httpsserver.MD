### deploy httpserver
```
kubectl create ns securesvc
kubectl label ns securesvc istio-injection=enabled
kubectl create -f httpserver.yaml -n securesvc
```
```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=cncamp Inc./CN=*.cncamp.io' -keyout cncamp.io.key -out cncamp.io.crt
kubectl create -n istio-system secret tls cncamp-credential --key=cncamp.io.key --cert=cncamp.io.crt
kubectl apply -f istio-specs.yaml -n securesvc
```

### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   $INGRESS_IP
```
### access the httpserver via ingress
```
curl --resolve httpsserver.cncamp.io:443:$INGRESS_IP https://httpsserver.cncamp.io/healthz -v -k
```
