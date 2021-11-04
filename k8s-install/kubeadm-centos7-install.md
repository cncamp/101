## Preparation
- [virtualbox6.1](https://www.virtualbox.org/)
- [centos iso](https://mirrors.aliyun.com/centos/7/isos/x86_64/)
## install

### virtualbox
- create a new box
  - name
  - folder path
  - type: Linux
  - version: Other Linux (64-bit)
- memory
  - 4096M
- cpu
  - number:2
  - peak load: 100%
- hard disk
  - create a virtual hard disk now
  - choose VDI
  - Fixed size
  - 100GB
- network
  - adapter1
    - Attached to: NAT
    - Advanced: default
    - notice: remember `MAC Address`(080027A71D80), we could use it later for linux setting
  - adapter2
    - Attached to: Host-only Adapter
    - Name: vboxnet0
    - advanced:default
    - notice: remember `MAC Address(0800271EED5C)`, we could use it later for linux setting

- set iso file
  - choose your box, right click it, then choose setting
  - storage
  - choose the logo which is like a CD
    - Attributes => Optical Drive: (click the CD logo and choose your centos iso file)

### centos7
- double click your box
- start (you could make sure the ios again)
- install centos7
- language:English
- Date&Time: Asia/Shanghai
- System
  - Installation destination: choose your vdi 
- Begin installation
- Root password
- reboot
- login
- set network adapter
  - vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
    ```
    HWADDR=08:00:27:0A:E8:8F
    TYPE=Ethernet
    PROXY_METHOD=none
    BROWSER_ONLY=no
    BOOTPROTO=dhcp
    DEFROUTE=yes
    IPV4_FAILURE_FATAL=no
    IPV6INIT=yes
    IPV6_AUTOCONF=yes
    IPV6_DEFROUTE=yes
    IPV6_FAILURE_FATAL=no
    IPV6_ADDR_GEN_MODE=stable-privacy
    NAME=enp0s3
    UUID=a88c90f7-f616-48ab-ba82-335c2d5c652d
    DEVICE=enp0s3
    ONBOOT=yes
    ```
    - vi /etc/sysconfig/network-scripts/ifcfg-enp0s8
    ```
    HWADDR=08:00:27:DC:76:AA
    TYPE=Ethernet
    PROXY_METHOD=none
    BROWSER_ONLY=no
    BOOTPROTO=static
    DEFROUTE=yes
    IPV4_FAILURE_FATAL=no
    IPV6INIT=yes
    IPV6_AUTOCONF=yes
    IPV6_DEFROUTE=yes
    IPV6_FAILURE_FATAL=no
    IPV6_ADDR_GEN_MODE=stable-privacy
    NAME=enp0s8 // Note that it is consistent with the file name suffix
    UUID=a88c90f7-f616-48ab-ba82-335c2d5c652d
    DEVICE=enp0s8 // Note that it is consistent with the file name suffix
    ONBOOT=yes
    NM_CONTROLLED=yes
    IPADDR=192.168.56.200 
    NETMASK=255.255.255.0
    GATEWAY=192.168.56.1
    DNS1=8.8.8.8
    ```
- vi /etc/hostname
  - vm210
  - notice: don't use underline and special characters
- vi /etc/hosts
```
192.168.56.210 vm210
192.168.56.211 vm211
192.168.56.212 vm212
```
- shutdown -r
- login again
- ping a website you know. if you could visit it which we could make sure the network is ok now.
- next, you could use item2 to make the next setps, because it's quite easy to edit your content.
- iptables
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
```
- firewall
```
systemctl stop firewalld
systemctl disable firewalld
systemctl status firewalld

```
- SELinux
```
vi /etc/selinux/config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
#SELINUX=enforcing
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
#SELINUXTYPE=targeted 
SELINUX=disabled 
```
- swap 
```
// temp turn off
[root@vm210 ~]# swapoff -a
// Permanently turn off
[root@vm210 ~]# vi /etc/fstab

#
# /etc/fstab
# Created by anaconda on Sun Aug 22 00:58:48 2021
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=be6fcb6b-d425-4cc6-9e97-0bba2b1c7236 /boot                   xfs     defaults        0 0
/dev/mapper/centos-home /home                   xfs     defaults        0 0
#/dev/mapper/centos-swap swap                    swap    defaults        0 0  // Comment out the current line

[root@vm210 ~]# shutdown -r
```

- timezone sync
```
yum install ntp
systemctl enable ntpd
systemctl start ntpd
timedatectl set-timezone Asia/Shanghai
timedatectl set-ntp yes
ntpq -p
```
### kubedam
- [install docker](https://docs.docker.com/engine/install/centos/)
  - note：don't install docker with centos, you should choose docker-ce
- yum source
```
vi /etc/yum.repos.d/kubernetes.repo

# choose the right baseurl which you feel better in your country.
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
```
- kubelet kubeadm install
```
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet
```
- system starts docker
```
systemctl enable docker && systemctl start docker
```

- kubeadm
```
[root@vm210 ~]# kubeadm init   --image-repository registry.aliyuncs.com/google_containers   --kubernetes-version v1.22.0   --apiserver-advertise-address=192.168.56.130
[init] Using Kubernetes version: v1.22.0
[preflight] Running pre-flight checks
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR NumCPU]: the number of available CPUs 1 is less than the required 2
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher

[root@vm210 ~]# kubelet --cgroupDriver
E0821 18:06:43.647211    8799 server.go:158] "Failed to parse kubelet flag" err="unknown flag: --cgroupDriver"

[root@vm210 ~]# systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
  Drop-In: /usr/lib/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since 六 2021-08-21 18:19:45 CST; 5s ago
     Docs: https://kubernetes.io/docs/
  Process: 8186 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)
 Main PID: 8186 (code=exited, status=1/FAILURE)

8月 21 18:19:45 vm210 systemd[1]: kubelet.service: main process exited, code=exited, status=1/FAILURE
8月 21 18:19:45 vm210 systemd[1]: Unit kubelet.service entered failed state.
8月 21 18:19:45 vm210 systemd[1]: kubelet.service failed.

[root@vm210 ~]#vim /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
[root@vm210 ~]#systemctl daemon-reload
[root@vm210 ~]#systemctl restart docker
// unable to configure the Docker daemon with file /etc/docker/daemon.json
// choose to install docker-ce will solve this problem.

[root@vm210 ~]#systemctl restart kubelet

// run kuebeadm again
ERROR: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
errors pretty printing info
, error: exit status 1
	[ERROR Service-Docker]: docker service is not active, please run 'systemctl start docker.service'

[root@vm210 ~]#systemctl start docker.service

error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR ImagePull]: failed to pull image registry.aliyuncs.com/google_containers/coredns:v1.8.4: output: Error response from daemon: manifest for registry.aliyuncs.com/google_containers/coredns:v1.8.4 not found: manifest unknown: manifest unknown

[root@vm210 ~]# docker pull coredns/coredns
Using default tag: latest
latest: Pulling from coredns/coredns
c6568d217a00: Pull complete
bc38a22c706b: Pull complete
Digest: sha256:6e5a02c21641597998b4be7cb5eb1e7b02c0d8d23cce4dd09f4682d463798890
Status: Downloaded newer image for coredns/coredns:latest
docker.io/coredns/coredns:latest

[root@vm210 ~]# docker images
REPOSITORY                                                        TAG       IMAGE ID       CREATED        SIZE
registry.aliyuncs.com/google_containers/kube-apiserver            v1.22.0   838d692cbe28   2 weeks ago    128MB
registry.aliyuncs.com/google_containers/kube-controller-manager   v1.22.0   5344f96781f4   2 weeks ago    122MB
registry.aliyuncs.com/google_containers/kube-proxy                v1.22.0   bbad1636b30d   2 weeks ago    104MB
registry.aliyuncs.com/google_containers/kube-scheduler            v1.22.0   3db3d153007f   2 weeks ago    52.7MB
registry.aliyuncs.com/google_containers/etcd                      3.5.0-0   004811815584   2 months ago   295MB
coredns/coredns                                                   latest    8d147537fb7d   2 months ago   47.6MB
registry.aliyuncs.com/google_containers/pause                     3.5       ed210e3e4a5b   5 months ago   683kB

[root@vm210 ~]# docker tag coredns/coredns:latest registry.aliyuncs.com/google_containers/coredns:v1.8.4

[root@vm210 ~]# docker rmi coredns/coredns:latest

// success infomation
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.56.130:6443 --token i36hnn.8trjybo0msel27y6 \
	--discovery-token-ca-cert-hash sha256:4667ecb1cbe7692b8bef1d3fac79be22a8cf3d2086f8fd5538e00fb2b08b9ee3
```
- clusters
```
// master
kubectl get pods --all-namespaces
NAMESPACE     NAME                            READY   STATUS    RESTARTS      AGE
kube-system   coredns-7f6cbbb7b8-9mg2x        0/1     Pending   0             8h
kube-system   coredns-7f6cbbb7b8-fldxl        0/1     Pending   0             8h
kube-system   etcd-vm210                      1/1     Running   4 (25m ago)   8h
kube-system   kube-apiserver-vm210            1/1     Running   3 (25m ago)   8h
kube-system   kube-controller-manager-vm210   1/1     Running   2 (25m ago)   8h
kube-system   kube-proxy-562x7                1/1     Running   1 (25m ago)   8h
kube-system   kube-proxy-dnwth                1/1     Running   1             95m
kube-system   kube-proxy-w2vth                1/1     Running   0             54m
kube-system   kube-scheduler-vm210            1/1     Running   5 (25m ago)   8h

You must deploy a Container Network Interface (CNI) based Pod network add-on 
so that your Pods can communicate with each other. 
Cluster DNS (CoreDNS) will not start up before a network is installed.

[root@vm210 ~]# kuletadm reset 
[root@vm210 ~]# kubeadm init   
    --image-repository registry.aliyuncs.com/google_containers  \
    --kubernetes-version v1.22.0  \
    --apiserver-advertise-address=192.168.56.210 \
    --pod-network-cidr=192.168.1.0/16

[root@vm210 ~]# wget https://docs.projectcalico.org/manifests/tigera-operator.yaml
[root@vm210 ~]# wget https://docs.projectcalico.org/manifests/custom-resources.yaml
// you should let the cidr match your network range, don not use the url to install directly.
[root@vm210 ~]# vim custom-resources.yaml
  cidr: 192.168.0.0/16  => cidr: 192.168.1.0/16
[root@vm210 ~]# kubectl create -f tigera-operator.yaml
[root@vm210 ~]# kubectl create -f custom-resources.yaml

[root@vm210 ~]# watch kubectl get pods -n calico-system
Every 2.0s: kubectl get pods -n calico-system                                                                                                                                                                         Sat Aug 21 02:22:02 2021

NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-868b656ff4-5fh56   1/1     Running   0          56m
calico-node-4729c                          1/1     Running   0          56m
calico-node-74xwl                          1/1     Running   0          51m
calico-node-fgs7j                          1/1     Running   1          51m
calico-typha-884bbd9c6-dd7lm               1/1     Running   1          51m
calico-typha-884bbd9c6-kktwc               1/1     Running   4          51m
calico-typha-884bbd9c6-xj9rc               1/1     Running   0          56m

[root@vm210 ~]# watch kubectl get nodes
NAME    STATUS   ROLES                  AGE   VERSION
vm210   Ready    control-plane,master   59m   v1.22.0
vm211   Ready    <none>                 52m   v1.22.0
vm212   Ready    <none>                 51m   v1.22.1

------------------------------------------------------

// node1
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
                 
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io
systemctl start docker

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet

kubeadm join 192.168.56.210:6443 --token s2n0yr.0g5ujjrfthvjvr07 \
--discovery-token-ca-cert-hash sha256:81974851f2e10bdb8bc401ebe2e0b16dc500bd13261342d80d9643ef4dc94a05

[root@vm210 ~]# kubectl get nodes
[kubelet-check] It seems like the kubelet isn't running or healthy.
[kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.

// solve the problem above
[root@vm210 ~]#vim /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
[root@vm210 ~]#systemctl daemon-reload
[root@vm210 ~]#systemctl restart docker
[root@vm210 ~]#systemctl restart kubelet

[root@vm211 ~]# kubectl get nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

kubectl version -o json
kubectl cluster-info
[root@vm211 ~]# kubectl cluster-info

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
The connection to the server localhost:8080 was refused - did you specify the right host or port?

[root@vm210 ~] systemctl status kubelet
[root@vm210 ~] journalctl -xeu kubelet
// Unable to update cni config" err="no networks found in /etc/cni/net.d
// if you encounter this problem, just to redo all the activity above on the node.

```

## summary
- What we need to note during the entire installation process is that don't just to search the key you see with command 'systemctl status kubelet' or 'journalctl -u kubelet'
- we must pay more attention to the args like $KUBELET_EXTRA_ARGS when we encounter some errors.
```
'Process: 8998 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=1/FAILURE)'
```
### Errors
- The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp [::1]:10248: connect: connection refused.
  - systemctl restart kubelet
- [root@vm210 ~]# kubelet --cgroupDriver
E0820 13:16:23.223925   31791 server.go:158] "Failed to parse kubelet flag" err="unknown flag: --cgroupDriver"
  - EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
  - remove the arg `cgroupDriver`
  - systemctl restart kubelet
- check network
  - ip a
  - cat /etc/resolv.conf
## References
- [The kubelet drop-in file for systemd](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/kubelet-integration/#the-kubelet-drop-in-file-for-systemd) 
- [kubelet failed with kubelet cgroup driver: “cgroupfs” is different from docker cgroup driver: “systemd”](https://stackoverflow.com/questions/45708175/kubelet-failed-with-kubelet-cgroup-driver-cgroupfs-is-different-from-docker-c)
- [Configuring each kubelet in your cluster using kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/kubelet-integration/#the-kubelet-drop-in-file-for-systemd)
- [Installing kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [Quickstart for Calico on Kubernetes](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
- [kubeadm安装k8s完整教程](https://segmentfault.com/a/1190000021209788)


