### Install prometheus

```sh
kubectl apply -f prometheus.yaml
```

### Install kiali

```sh
kubectl apply -f samples/addons/kiali.yaml
```

### Update kiali svc to NodePort

```sh
k edit svc kiali -n istio-system
```

### Access kiali, go to graph, select all namespaces

http://192.168.34.2:31816/
