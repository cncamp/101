### 下载 federation 代码

```sh
git clone https://github.com/kubernetes-sigs/kubefed.git
```

### 选择 HostCluster，确认 kubeconfig 符合 federatio 命名规范，用 vi 编辑 kubeconfig，确保 context 属性没用@字符

```sh
vi ~/.kube/config
```

```yaml
contexts:
- context:
  cluster: kubernetes
  user: kubernetes-admin
  name: `cluster1`
  current-context: `cluster1`
```

### 安装

```sh
kind create cluster
make deploy.kind
kubectl -n kube-federation-system get kubefedcluster -oyaml
```

### Fix

```sh
k get po -n kube-system kube-apiserver-kind-control-plane
kube-system              kube-apiserver-kind-control-plane             1/1     Running   0          24m     172.18.0.2    kind-control-plane   <none>           <none>
172.18.0.2
```

### 安装完成后查看 federation

```sh
kubectl get all -n kube-federation-system
```

### 将 namespace 设置为联邦对象

```sh
kubectl create ns federate-me
./bin/kubefedctl federate ns federate-me
```

### 创建 FederatedDeployment

```sh
kubectl apply -f test-deployment.yaml -n federate-me
```

### 查看 membercluster 中的 deployment 对象

```sh
kubectl get deployment test-deployment -n federate-me
```

### 创建 RSP 对象

```sh
kubectl apply -f test-deployment-rsp.yaml -n federate-me
```

### 查看 membercluster 中的 deployment 对象

```sh
kubectl get deployment test-deployment -n federate-me
```

### 查看 federatedployment，会发现因为 rsp，federateddeployment 的 override 属性被更新了

```sh
kubectl get federateddeployment test-deployment -n federate-me
```

### 删除 rsp，发现 override 没有被拿掉
