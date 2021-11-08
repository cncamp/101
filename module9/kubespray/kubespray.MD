## prepare k8s vm
### install 2 ubuntu20.04 vm
### set network adapter
### add a host only adaptor and add the following settings
node1
```
cat /etc/netplan/00-installer-config.yaml
network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: no
      addresses:
        - 192.168.34.10/24
  version: 2
```
```
netplan apply
```
node2
```
cat /etc/netplan/00-installer-config.yaml

network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: no
      addresses:
        - 192.168.34.11/24
  version: 2
```
```
netplan apply
```
## Start k8s by kubespary
### Download kubespary docker image
docker pull quay.io/kubespray/kubespray:v2.16.0

### Clone kubespary source code
git clone https://github.com/kubernetes-sigs/kubespray.git

```
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub cadmin@192.168.34.10
ssh-copy-id -i ~/.ssh/id_rsa.pub cadmin@192.168.34.11
```

### Start kubespray
```
cd kubespray
docker run --net host --rm -it --name kubespray --mount type=bind,source="$(pwd)"/inventory/sample,dst=/inventory --mount type=bind,source="${HOME}"/.ssh/id_rsa,dst=/root/.ssh/id_rsa   quay.io/kubespray/kubespray:v2.16.0 bash
```

### prepare no password login for server

### build ansible inventory
cp -r inventory/sample inventory/mycluster
declare -a IPS=(192.168.34.10 192.168.34.11)
CONFIG_FILE=inventory/mycluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

### change gcr.io to mirror
cat > inventory/mycluster/group_vars/k8s_cluster/vars.yml << EOF
gcr_image_repo: "registry.aliyuncs.com/google_containers"
kube_image_repo: "registry.aliyuncs.com/google_containers"
etcd_download_url: "https://ghproxy.com/https://github.com/coreos/etcd/releases/download/{{ etcd_version }}/etcd-{{ etcd_version }}-linux-{{ image_arch }}.tar.gz"
cni_download_url: "https://ghproxy.com/https://github.com/containernetworking/plugins/releases/download/{{ cni_version }}/cni-plugins-linux-{{ image_arch }}-{{ cni_version }}.tgz"
calicoctl_download_url: "https://ghproxy.com/https://github.com/projectcalico/calicoctl/releases/download/{{ calico_ctl_version }}/calicoctl-linux-{{ image_arch }}"
calico_crds_download_url: "https://ghproxy.com/https://github.com/projectcalico/calico/archive/{{ calico_version }}.tar.gz"
crictl_download_url: "https://ghproxy.com/https://github.com/kubernetes-sigs/cri-tools/releases/download/{{ crictl_version }}/crictl-{{ crictl_version }}-{{ ansible_system | lower }}-{{ image_arch }}.tar.gz"
nodelocaldns_image_repo: "cncamp/k8s-dns-node-cache"
dnsautoscaler_image_repo: "cncamp/cluster-proportional-autoscaler-amd64"
EOF

### change remote user
#### on host src folder
vi ansible.cfg
add remote_user=cadmin to [default] section
docker cp ansible.cfg kubespray:/kubespray/ansible.cfg

ansible-playbook -i inventory/mycluster/hosts.yml cluster.yml -b -v \
  --private-key=~/.ssh/id_rsa
```

```markdown

### error, the following error cause by slow network in China
Data could not be sent to remote host \"192.168.34.11\". Make sure this host can be reached over ssh:
### error
dpkg: error: dpkg frontend lock is locked by another process

rm /var/lib/dpkg/lock
rm /var/lib/dpkg/lock-frontend
rm /var/cache/apt/archives/lock

### if you meet same error when downloading image, you can pull the image before retry

```