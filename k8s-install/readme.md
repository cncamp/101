# Install Kubernetes Cluster

## 一些小建议

众多初学者在入门Kubernetes的时候，第一步是安装Kubernetes集群，并在此过程中消耗大量的时间。但是，如果没有足够的耐心，将很有可能被各种Kubernetes的众多新概念所劝退。

所以在此，建议初学者先利用便捷的工具安装一个学习用的测试集群，利用测试集群先学习Kubernetes中的新概念。

了解核心组件的工作原理后，再尝试自行对组件进行调参。

当你学习到后面之后，会发现安装集群似乎并没有那么的重要。

因为不懂核心原理，你也难以发挥出Kubernetes的强大之处。就如同一个小孩子拿着一个功能强大的工具箱玩耍。

## 选择合适的安装工具

在此小节，将会为你推荐安装集群的工具以及Kubernetes发行版本。

标准Kubernetes集群的**最低要求**:

1. 一个Master节点，2C4G
2. 一个Node节点，2C4G

该配置可以满足大多数的单应用，基本满足单个模块的学习。

但是，无法满足多个应用同时运行或者运行监控套件的需求。

---

如果无法提供每个节点4G的资源，那么可以选择k3s或者将节点运行在Docker中。

**k3s在512MB的树莓派都可以跑起来, 且兼容Kubernetes的标准API。** 因此无需过度担心因资源不足而导致无法实践对应模块的内容。

---

如果想将测试集群当做一次性用品，那么可以选择使用`autok3s`自动购买云厂商的竞价实例，并搭建好测试集群。

每一次的实验费用都非常的低廉和实惠。

---

在后续的模块中，会优先兼顾`kubeadm`以及`k3s`。

`kubeadm`提供的方案可以说是Kubernetes的官方方案，而`k3s`则是IOT环境下的一个重要代表。

!!! tips
    点击名称，可直接跳转到该工具介绍

``` mermaid
graph TB
  A[Start] --> B{Memory For Each Node > 4GB?};
  B --> |Yes| C("kubeadm (Recommend)") & J(kubekey) & K(sealyun);
  B --> |No| D{Running in Docker?};
  D --> |Yes| E("kind (Recommend)") & F(k3d) &  H(minikube);
  D --> |No| G("k3s (Recommend)");
  click C "/k8s-install/readme/#kubeadm"
  click E "/k8s-install/readme/#kind"
```


## kubeadm

!!! Tips
     Kubeadm是本实践指南优先支持的环境之一。

Kubeadm is a tool built to provide best-practice "fast paths" for creating Kubernetes clusters. It performs the actions necessary to get a minimum viable, secure cluster up and running in a user friendly way. Kubeadm's scope is limited to the local node filesystem and the Kubernetes API, and it is intended to be a composable building block of higher level tools.

kubeadm 通过容器化的方式自管理Kubernetes核心组件。利用Kubernetes的自身特性，可以天然地做到高可用。

通过 kubeadm 安装，需要手工安装 CRI，kubelet，kubeadm，CNI 等。

- [Official Documentation (Recommend)](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [Install Kubernetes Via Kubeadm In Ubuntu](k8s-by-kubeadm/index.md)
- [Install Kubernetes Via Kubeadm In CentOS](kubeadm-centos7-install.md) @水果爸爸

## kind

kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.

通过 [kind](kind.md) 安装，全自动，无手工步骤，快捷简单，但是节点是基于容器而不是虚拟机的。

## k3s

Lightweight Kubernetes.  Production ready, easy to install, half the memory, all in a binary less than 100 MB.

Great for:

* Edge
* IoT
* CI
* Development
* ARM
* Embedding k8s
* Situations where a PhD in k8s clusterology is infeasible

## k3d

k3d is a lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker.

k3d makes it very easy to create single- and multi-node k3s clusters in docker, e.g. for local development on Kubernetes.

## minikube

通过 [minikube](1.minikube-setup.md) 安装。

## Vagrant

如果配置 kubeadm 有困难可参考 [Vagrantfile](Vagrantfile) @nevil

## 跨公网安装集群

- [利用 Kilo 跨公网组建 k3s 集群](https://zsnmwy.notion.site/Kilo-k3s-a3b5c98fab14432594f6bdbaeffb7c77)
- [利用 FabEdge 跨公网组建 k3s 集群](https://zsnmwy.notion.site/FabEdge-k3s-43ef0b8662be4c70bc74185c05cd517e)
