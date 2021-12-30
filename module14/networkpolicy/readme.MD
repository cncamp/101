### Create workload

```sh
kubectl apply -f serverpod.yaml
```

### Create default networkpolicy

```sh
kubectl apply -f networkpolicy.yaml
```

### Check server pod

```sh
kubectl get po -n calico-demo -owide
```

### Start clientpod

```sh
kubectl apply -f toolbox.yaml
kubectl apply -f toolbox.yaml -n calico-demo
```

### Enter toolbox shell

```sh
kubectl exec it <podname> bash
```

### Test connectivity

```sh
curl <calico-pod-ip>
ping <calico-pod-ip>
```

### Create global allow policy

```sh
kubectl create -f allow-icmp-incluster.yaml
```

### Test connectivity

```sh
curl <calico-pod-ip>
ping <calico-pod-ip>
```
