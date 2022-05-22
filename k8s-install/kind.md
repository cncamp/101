# kind

下面的步骤将会引导您创建一个基于kind的Kubernetes集群 - `1 control plane node and 3 workers`。

### Install kind

Mac:

```sh
brew install kind
kind create cluster
```

其他平台的安装方式见: https://kind.sigs.k8s.io/docs/user/quick-start/#installation

### Create Cluster

#### create cluster configuration

```yaml title="kind-example-config.yaml"
# this config file contains all config fields with comments
# NOTE: this is not a particularly useful config file
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
# patch the generated kubeadm config with some extra settings
kubeadmConfigPatches:
- |
  apiVersion: kubelet.config.k8s.io/v1beta1
  kind: KubeletConfiguration
  evictionHard:
    nodefs.available: "0%"
# patch it further using a JSON 6902 patch
kubeadmConfigPatchesJSON6902:
- group: kubeadm.k8s.io
  version: v1beta2
  kind: ClusterConfiguration
  patch: |
    - op: add
      path: /apiServer/certSANs/-
      value: my-hostname
# 1 control plane node and 3 workers
nodes:
# the control plane node config
- role: control-plane
# the three workers
- role: worker
- role: worker
- role: worker
```

#### create cluster with configuration

```bash
# create cluster
kind create cluster --config kind-example-config.yaml
```

```log
$ kind create cluster --config ~/kind-example-config.yaml
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.21.1) 🖼
 ✓ Preparing nodes 📦 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
```

### Mirror

如果您无法正常访问镜像`kindest/node:<tag>`，那么可以使用daocloud的镜像源进行平替。

```base
kind create cluster --image docker.m.daocloud.io/kindest/node:<tag> --config kind-example-config.yaml
```
