### resetup rook
```
rm -rf /var/lib/rook
```
### add a new raw device
create a raw disk from virtualbox console and attach to the vm(must > 5G)
```
delete ns rook-ceph
for i in `kubectl api-resources | grep true | awk '{print \$1}'`; do echo $i;kubectl get $i -n rook-ceph; done
```
```
git clone --single-branch --branch master https://github.com/rook/rook.git
cd rook/cluster/examples/kubernetes/ceph
```
```
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
```
```
kubectl get po -n rook-ceph, wait for all pod being running
kubectl create -f cluster-test.yaml
```
```
kubectl get po -n rook-ceph, wait for all pod being running
kubectl create -f csi/rbd/storageclass-test.yaml
```


operator

start driver


```
k get configmap -n rook-ceph rook-ceph-operator-config -oyaml
ROOK_CSI_ENABLE_RBD: "true"
```
1. create csidriver
```
k get csidriver rook-ceph.rbd.csi.ceph.com
```

```
    name: csi-rbdplugin
    args:
    - --drivername=rook-ceph.rbd.csi.ceph.com
    - hostPath:
      path: /var/lib/kubelet/plugins/rook-ceph.rbd.csi.ceph.com
      type: DirectoryOrCreate
      name: plugin-dir
    - hostPath:
      path: /var/lib/kubelet/plugins
      type: Directory
      name: plugin-mount-dir

    name: driver-registrar
    args:
    - --csi-address=/csi/csi.sock
    - --kubelet-registration-path=/var/lib/kubelet/plugins/rook-ceph.rbd.csi.ceph.com/csi.sock
    - hostPath:
      path: /var/lib/kubelet/plugins_registry/
      type: Directory
      name: registration-dir
    - hostPath:
      path: /var/lib/kubelet/plugins/rook-ceph.rbd.csi.ceph.com
      type: DirectoryOrCreate
      name: plugin-dir
```    
```
k get po csi-rbdplugin-j4s6c -n rook-ceph -oyaml
/var/lib/kubelet/plugins/rook-ceph.rbd.csi.ceph.com
```
```
kubectl create -f cluster/examples/kubernetes/ceph/toolbox.yaml
```
