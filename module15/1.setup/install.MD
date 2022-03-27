### Install istio follow by module12

```sh
cd /root/istio-1.12.0
```

### Install bookinfo

```sh
kubectl label namespace default istio-injection=enabled
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
```

### Expose the application via istio ingress gateway

```sh
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

### Check ingress vip

```sh
export GATEWAY_URL=192.168.34.2:31783
```

### Access the productpage via

http://192.168.34.2:31783/productpage
