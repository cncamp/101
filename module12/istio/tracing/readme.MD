### Install

```sh
kubectl apply -f jaeger.yaml
kubectl edit configmap istio -n istio-system
set tracing.sampling=100
```

### Deploy tracing
```sh
kubectl create ns tracing
kubectl label ns tracing istio-injection=enabled
kubectl -n tracing apply -f service0.yaml
kubectl -n tracing apply -f service1.yaml
kubectl -n tracing apply -f service2.yaml
kubectl apply -f istio-specs.yaml -n tracing
```

### Check ingress ip

```sh
k get svc -nistio-system

istio-ingressgateway   LoadBalancer   $INGRESS_IP
```

### Access the tracing via ingress for 100 times(sampling rate is 1%)

```sh
curl $INGRESS_IP/service0
```

### Check tracing dashboard

```sh
istioctl dashboard jaeger
```
