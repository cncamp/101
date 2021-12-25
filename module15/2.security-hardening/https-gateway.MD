```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=cncamp Inc./CN=192.168.34.2' -keyout bookinfo.key -out bookinfo.crt
kubectl create -n istio-system secret tls bookinfo-credential --key=bookinfo.key --cert=bookinfo.crt
kubectl apply -f https-gateway.yaml
```