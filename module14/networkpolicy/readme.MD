### create workload
```
kubectl apply -f serverpod.yaml
```
### create default networkpolicy
```
kubectl apply -f networkpolicy.yaml
```
### check server pod
```
kubectl get po -n calico-demo -owide
```
### start clientpod
```
kubectl apply -f toolbox.yaml
kubectl apply -f toolbox.yaml -n calico-demo
```
### enter toolbox shell
```
kubectl exec it <podname> bash
```
### test connectivity
```
curl <calico-pod-ip>
ping <calico-pod-ip>
```
### create global allow policy
```
kubectl create -f allow-icmp-incluster.yaml
```
### test connectivity from two toolbox pod
```
curl <calico-pod-ip>
ping <calico-pod-ip>
```
### create networkpolicy to allow access
```
kubectl create -f access-calico-demo.yaml
```
### test connectivity from two toolbox pod
```
curl <calico-pod-ip>
ping <calico-pod-ip>
```