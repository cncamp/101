### Create dr for all services, this defines multiple subsets for all services

```sh
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
```

### Define virtualservice to route all traffic to v1

```sh
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
```

### Shift all request from jason to v2

```sh
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
```

### On the `/productpage` of the Bookinfo app, log in as user jason.
