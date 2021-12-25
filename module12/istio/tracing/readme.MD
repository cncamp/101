### install
```
kubectl apply -f jaeger.yaml
kubectl edit configmap istio -n istio-system
set tracing.sampling=100
```
### deploy tracing
```
kubectl create ns tracing
kubectl label ns tracing istio-injection=enabled
kubectl -n tracing apply -f service0.yaml
kubectl -n tracing apply -f service1.yaml
kubectl -n tracing apply -f service2.yaml 
kubectl apply -f istio-specs.yaml -n tracing
```
### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   $INGRESS_IP
```
### access the tracing via ingress for 100 times(sampling rate is 1%)
```
curl $INGRESS_IP/service0
```
### check tracing dashboard
```
istioctl dashboard jaeger
```
