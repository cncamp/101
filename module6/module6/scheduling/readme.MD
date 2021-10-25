### 测试强亲和
```
kubectl apply -f hard-node-affinity.yaml
```
### 观察pod
```
kubectl get po
kubectl describe po
```
### 测试弱亲和
```
kubectl apply -f soft-node-affinity.yaml
```
### 观察pod
```
kubectl get po
kubectl describe po
```
### 为什么改成了弱亲和还pending? 理解apply的可能问题
```
kubectl get po -oyaml
```