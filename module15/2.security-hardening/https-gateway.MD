### Enable sidecar auto inject

```sh
kubectl label namespace default istio-injection=enabled
```

### Go to istio root dir

```sh
cd istio-1.12.0/
```

### Create bookinfo app

```sh
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods
```

### Expose to gateway

```sh
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

### Check ingress service http nodePort

```sh
kubectl get svc -n istio-system
```

### Access productpage

```sh
curl http://192.168.34.2:31783/productpage
```

### Secure the gateway by https protocol

```sh
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=cncamp Inc./CN=192.168.34.2' -keyout bookinfo.key -out bookinfo.crt
kubectl create -n istio-system secret tls bookinfo-credential --key=bookinfo.key --cert=bookinfo.crt
kubectl apply -f https-gateway.yaml
```

### Access product page via

https://192.168.34.2:31106/productpage
