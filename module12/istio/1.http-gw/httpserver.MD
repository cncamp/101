

### 描述 

> 本模块的实例是将服务暴露到ingess-gateway 网关服务，对外提供服务

### **核心对象：Gateway** 

> 类型是Gateway （作用对象是：istio-ingressgateway，本质还是envoy）
> 作用的对象的标签是  selector: istio: ingressgateway  ；
> 监听80端口(svc port) ，协议是http/tcp ,匹配的域名是simple.cncamp.io  (访问时需要加头信息： -H"Host: simple.cncamp.io")

```yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: simple
spec:
  selector:
    istio: ingressgateway
  servers:
    - hosts:
        - simple.cncamp.io
      port:
        name: http-simple
        number: 80
        protocol: HTTP
```

> gateway 与svc 关联
> svc 定义gateway 相关信息：  gateways: - simple
```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: simple
spec:
  gateways:
    - simple
  hosts:
    - simple.cncamp.io
  http:
    - match:
        - port: 80
      route:
        - destination:
            host: simple.simple.svc.cluster.local
            port:
              number: 80
```





### **核心对象：VirtualService**

> 高级的svc  ,再svc 至上定义各种规则和策略
>
> 是istio 各种功能实现的最核心的对象


### Deploy simple

```sh
kubectl create ns simple
kubectl create -f simple.yaml -n simple
kubectl create -f istio-specs.yaml -n simple
```

### Check ingress ip

```sh
k get svc -nistio-system

istio-ingressgateway   LoadBalancer   10.108.31.242
```

### Access the simple via ingress

```sh
export INGRESS_IP=10.108.31.242
curl -H "Host: simple.cncamp.io" $INGRESS_IP/hello -v
```
