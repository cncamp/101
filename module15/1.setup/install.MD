### install istio follow by module12
```
cd /root/istio-1.12.0
```
### install bookinfo
```
kubectl label namespace default istio-injection=enabled
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
```

### expose the application via istio ingress gateway
```
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```
### check ingress vip
```
export GATEWAY_URL=192.168.34.2:31783
```
### access the productpage via
```
http://192.168.34.2:31783/productpage
```

