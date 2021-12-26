### install prometheus

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/prometheus.yaml

### install kiali
```
kubectl apply -f samples/addons/kiali.yaml
```
### update kiali svc to NodePort
```
k edit svc kiali -n istio-system
```
### access kiali, go graph, select all namespaces 
```
http://192.168.34.2:31816/
```