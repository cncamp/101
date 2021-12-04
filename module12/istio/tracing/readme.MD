### install
```
kubectl apply -f jaeger.yaml
kubectl edit configmap istio -n istio-system
set tracing.sampling=100
```
### deploy istiodemo
```
kubectl create ns istiodemo
kubectl label ns istiodemo istio-injection=enabled
kubectl create -f service*.yaml -n istiodemo
kubectl create -f istio-specs.yaml -n istiodemo
```
### check ingress ip
```
k get svc -nistio-system
istio-ingressgateway   LoadBalancer   10.105.227.152
```
### access the istiodemo via ingress for 100 times(sampling rate is 1%)
```
curl <ingress>:/service0
```
### check tracing dashboard
```
istioctl dashboard jaeger
```
