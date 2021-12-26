### access service via service ip
```
k get svc
NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
details       ClusterIP   10.111.90.142    <none>        9080/TCP   6d5h
kubernetes    ClusterIP   10.96.0.1        <none>        443/TCP    13d
productpage   ClusterIP   10.111.120.47    <none>        9080/TCP   6d5h
ratings       ClusterIP   10.106.145.231   <none>        9080/TCP   6d5h
reviews       ClusterIP   10.109.136.179   <none>        9080/TCP   6d5h
simple        ClusterIP   10.97.215.11     <none>        80/TCP     7d4h
```
### access product page directly
```
curl 10.111.120.47:9080
```
### enable mtls globally
```
kubectl apply -f mtls.yaml -n istio-system
```
### access product page directly again, and it will fail with connection reset error
```
curl 10.111.120.47:9080
```
### access the gateway page via istio ingress gateway and it is still working
```
https://192.168.34.2:31106/productpage
```