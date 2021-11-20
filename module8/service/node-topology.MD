### add topology labels to node
```
kubectl label node topology.kubernetes.io/zone=sh-01
kubectl label node topology.kubernetes.io/region=sh
kubectl label node kubernetes.io/hostname=node1
```