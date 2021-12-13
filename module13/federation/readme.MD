### 下载federation代码
```
git clone https://github.com/kubernetes-sigs/kubefed.git
```
### 选择HostCluster，确认kubeconfig符合federatio命名规范，用vi编辑kubeconfig，确保context属性没用@字符
```
vi ~/.kube/config 
```

contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: `cluster1`
current-context: `cluster1`

### 安装
```
kind create cluster
make deploy.kind
kubectl -n kube-federation-system get kubefedcluster
```
### fix
```
k get po -n kube-system kube-apiserver-kind-control-plane 
kube-system              kube-apiserver-kind-control-plane             1/1     Running   0          24m     172.18.0.2    kind-control-plane   <none>           <none>
172.18.0.2
```
### 安装完成后查看federation
```
kubectl get all -n kube-federation-system
```
### 将namespace设置为联邦对象
```
kubectl create ns federate-me
./bin/kubefedctl federate ns federate-me

```
### 创建FederatedDeployment
```
kubectl apply -f test-deployment.yaml -n federate-me
```
### 查看membercluster中的deployment对象
```
kubectl get deployment test-deployment -n federate-me
```
### 创建RSP对象
```
kubectl apply -f test-deployment-rsp.yaml -n federate-me
```
### 查看membercluster中的deployment对象
```
kubectl get deployment test-deployment -n federate-me
```
### 查看federatedployment，会发现因为rsp，federateddeployment的override属性被更新了
```
kubectl get federateddeployment test-deployment -n federate-me
```
### 删除rsp，发现override没有被拿掉