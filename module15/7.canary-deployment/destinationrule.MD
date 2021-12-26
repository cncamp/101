### create dr for all services, this defines multiple subsets for all services 
```
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
```
### define virtualservice to route all traffic to v1
```
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
```
### shift all request from jason to v2 
```
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
```
### On the /productpage of the Bookinfo app, log in as user jason.
