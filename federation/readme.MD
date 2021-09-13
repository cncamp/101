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
cd kubefed/
./scripts/deploy-kubefed-latest.sh
```
### 安装完成后查看federation
```
kubectl get all -n kube-federation-system
```
### 将namespace设置为联邦对象
```
kubefedctl federate ns default
```
### 创建FederatedDeployment
```
kubectl create -f test-deployment.yaml
```
### 查看membercluster中的deployment对象
```
kubectl get deployment test-deployment
```
### 创建RSP对象
```
kubectl create -f test-deployment-rsp.yaml
```
### 查看membercluster中的deployment对象
```
kubectl get deployment test-deployment
```
### 查看federatedployment，会发现因为rsp，federateddeployment的override属性被更新了