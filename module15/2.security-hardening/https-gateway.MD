### enable sidecar auto inject
```
kubectl label namespace default istio-injection=enabled
```
### cd istio root
```
cd istio-1.12.0/
```
### create bookinfo app
```
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods
```
### create expose to gateway
```
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```
### check ingress service http nodePort
```
kubectl get svc -n istio-system
```
### access productpage
```
curl http://192.168.34.2:31783/productpage
```

### secure the gateway by https protocol
```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=cncamp Inc./CN=192.168.34.2' -keyout bookinfo.key -out bookinfo.crt
kubectl create -n istio-system secret tls bookinfo-credential --key=bookinfo.key --cert=bookinfo.crt
kubectl apply -f https-gateway.yaml
```
### access product page via safari(chrome blocks self sign certs)
```
https://192.168.34.2:31106/productpage
```
