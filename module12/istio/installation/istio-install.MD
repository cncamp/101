```
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.12.0
cp bin/istioctl /usr/local/bin
istioctl install --set profile=demo -y
```

```
kubectl create ns httpserver
kubectl create -f httpserver.yaml -n httpserver
kubectl create -f httpclient.yaml -n httpserver
```