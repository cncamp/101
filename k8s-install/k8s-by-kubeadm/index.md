# Install Kubernetes Via Kubeadm In Ubuntu

If you are using Macbook, start from here:

## Download images and tools

### Install virtualbox

https://www.virtualbox.org/wiki/Downloads

From System Preference -> Security & Privacy, allow Oracle access

From Virtualbox -> File -> Host Network Manager, click Create button to create one

### Install ubuntu iso from below link

https://releases.ubuntu.com/20.04/

## Installation and configuration

### Configuration virtualbox

#### Open virtualbox manager console

#### Ensure you have correct host network manager settings

- properties -> vboxnet0 -> 192.168.34.1/24
- If the subnet is different, you can edit and update it
- Do not enable dhcp

### Boot new VM

- Click new button
- Choose OS as ubuntu 64bit and 30G disk, make sure your #CPU>=2
- Start VM, choose the downloaded ubuntu ISO and follow the installation wizard
- Specify username/password like cadmin/cadmin
- Install ssh server, enable and start the service
- Do not install built-in kubenernetes
- Wait enough long for the os installation complete

### Shutdown the OS, and set 2nd network adapter

- Go to VM->settings->network->adapter 2
- Enable the adapter and select host only adapter, and choose vboxnet0, `vboxnet0` the host network name configured above

### Login to the system and set ip for second adapter

```sh
vi /etc/netplan/00-installer-config.yaml

network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: no
      addresses:
        - 192.168.34.2/24
  version: 2
```

```sh
netplan apply
```

### Network configuration

Now your VM has two adapters:

- One is NAT which will get an IP automatically, generally it's 10.0.2.15, this interface is for external access from your VM
- One is host adapter which need create extra ip, which is configured as 192.168.34.2
  the reason we need the host adapter and static IP is then we can set this static IP as k8s advertise IP and you can move your VM in different everywhere.(otherwise your VM IP would be changed in different environment)

### Set no password for sudo

```sh
%sudo ALL=(ALL:ALL) NOPASSWD:ALL
```

### Swap off

```sh
swapoff -a
vi /etc/fstab
remove the line with swap keyword
```

## Install docker

```sh
apt install docker.io
```

### Update cgroupdriver to systemd

```sh
vi /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
systemctl daemon-reload
systemctl restart docker
```

### Letting iptables see bridged traffic

```shell
$ cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

$ cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
$ sudo sysctl --system
```

### Update the apt package index and install packages needed to use the Kubernetes apt repository:

```shell
$ sudo apt-get update
$ sudo apt-get install -y apt-transport-https ca-certificates curl
```

## Install kubeadm

```shell
$ sudo curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
```

### Add the Kubernetes apt repository

```shell
$ sudo tee /etc/apt/sources.list.d/kubernetes.list <<-'EOF'
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main
EOF
```

### Update apt package index, install kubelet, kubeadm and kubectl

```shell
$ sudo apt-get update
$ sudo apt-get install -y kubelet kubeadm kubectl
$ sudo apt-mark hold kubelet kubeadm kubectl
```

### kubeadm init
```shell
$ echo "192.168.34.2 cncamp.com" >> /etc/hosts
```

```shell
$ kubeadm init \
 --image-repository registry.aliyuncs.com/google_containers \
 --kubernetes-version v1.22.2 \
 --pod-network-cidr=192.168.0.0/16 \
 --apiserver-advertise-address=192.168.34.2
```

### Copy kubeconfig

```shell
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Untaint master

```shell
$ kubectl taint nodes --all node-role.kubernetes.io/master-
```

## Install calico cni plugin

https://docs.projectcalico.org/getting-started/kubernetes/quickstart

```shell
$ kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
$ kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
```

## if you want to enable containerd during start, set the cri-socket parameter during kubeadm init
```
kubeadm init \
 --image-repository registry.aliyuncs.com/google_containers \
 --kubernetes-version v1.22.2 \
 --pod-network-cidr=192.168.0.0/16 \
 --cri-socket /run/containerd/containerd.sock \
 --apiserver-advertise-address=192.168.34.2
```

## Resize VM

### fdisk

```sh
fdisk /dev/sda
p - partition
n - new
```

### Create new pv

```sh
pvcreate /dev/sda4
vgdisplay
```

### Add new pv to vg

```sh
vgextend ubuntu-vg /dev/sda4
```

### Check rootfs lv path

```sh
vgdisplay
lvdisplay
```

### Resize root fix

```sh
lvextend --size +19.99G --resizefs /dev/ubuntu-vg/ubuntu-lv
```
