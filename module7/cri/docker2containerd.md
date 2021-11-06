https://kubernetes.io/zh/docs/setup/production-environment/container-runtimes/#containerd

### stop service
```
systemctl stop kubelet
systemctl stop docker
systemctl stop containerd
```
### create containerd config folder
```
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
```
### update default config
```
vi /etc/containerd/config.toml
sed -i s#k8s.gcr.io/pause:3.5#registry.aliyuncs.com/google_containers/pause:3.5#g /etc/containerd/config.toml
sed -i s#'SystemdCgroup = false'#'SystemdCgroup = true'#g /etc/containerd/config.toml
```
### edit kubelet config and add extra args
```
vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
Environment="KUBELET_EXTRA_ARGS=--container-runtime=remote --container-runtime-endpoint=unix:///run/containerd/containerd.sock"
```
### restart 
```
systemctl daemon-reload 
systemctl restart containerd 
systemctl restart kubelet 
```
### config crictl to set correct endpoint
```
cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
EOF
```
