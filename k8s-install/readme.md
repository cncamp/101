### Install Kubernetes Cluster

### kubeadm

通过kubeadm安装，需要手工安装docker，kubelet，kubeadm等

- ubuntu安装 [kubeadmin-setup.md](k8s-by-kubeadm)
- centos安装 [kubeadm-centos7-install.md](kubeadm-centos7-install.md) @水果爸爸
### kind

通过kind安装，全自动，无手工步骤，快捷简单，但是节点是基于容器而不是虚拟机的。

[kind-setup.md](1.2.kind-setup.md)

### minikube

[minikube](1.minikube-setup.md)

### Vagrant

如果配置kubeadm有困难可参考 [Vagrantfile](Vagrantfile) @nevil
