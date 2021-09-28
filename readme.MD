## A basic instruction for Kubernetes setup and understanding
1. cluster setup
- 通过kubeadm安装，需要手工安装docker，kubelet，kubeadm等
    - ubuntu安装 [kubeadmin-setup.md](k8s-by-kubeadm)
      - 如果配置kubeadm有困难可参考 [Vagrantfile](Vagrantfile) @nevil
    - centos安装 [kubeadm-centos7-install.md](kubeadm-centos7-install.md) @水果爸爸
- 通过kind安装，全自动，无手工步骤，快捷简单，但是节点是基于容器而不是虚拟机的

    [kind-setup.md](1.2.kind-setup.md)


2. [understand-docker.md](2.understand-docker.md)
3. [microservice.md](3.microservice.md)

## A basic instruction for Istio setup and understanding
4. [istio-setup.md](4.istio-setup.md)
5. [understand-istio.md](5.understand-istio.md)

