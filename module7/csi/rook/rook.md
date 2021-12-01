### resetup rook
```
rm -rf /var/lib/rook
```
### add a new raw device
create a raw disk from virtualbox console and attach to the vm(must > 5G)
### clean env for next demo
```
delete ns rook-ceph
for i in `kubectl api-resources | grep true | awk '{print \$1}'`; do echo $i;kubectl get $i -n rook-ceph; done
```
### checkout rook
```
git clone --single-branch --branch master https://github.com/rook/rook.git
cd rook/cluster/examples/kubernetes/ceph
```
### create rook operator
```
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
```
### create ceph cluster
```
kubectl get po -n rook-ceph, wait for all pod being running
kubectl create -f cluster-test.yaml
```
### create storage class
```
kubectl get po -n rook-ceph, wait for all pod being running
kubectl create -f csi/rbd/storageclass-test.yaml
```
### check configuration
```
k get configmap -n rook-ceph rook-ceph-operator-config -oyaml
ROOK_CSI_ENABLE_RBD: "true"
```
### check csidriver
```
k get csidriver rook-ceph.rbd.csi.ceph.com
```
### check csi plugin configuration
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
### create toolbox when required
```
kubectl create -f cluster/examples/kubernetes/ceph/toolbox.yaml
```
### test networkstorage
```
kubectl create -f pvc.yaml
kubectl create -f pod.yaml
```
### enter pod and write some data
```
kubeclt exec -it task-pv-pod sh
cd /mnt/ceph
echo hello world > hello.log
```
### exit pod and delete the po
```
kubectl create -f pod.yaml
```
### recreate the pod and check /mnt/ceph again, and you will find the file is there
```
kubectl delete -f pod.yaml
kubectl create -f pod.yaml
kubeclt exec -it task-pv-pod sh
cd /mnt/ceph
ls
```
### expose dashboard
```
kubectl get svc rook-ceph-mgr-dashboard -n rook-ceph -oyaml>svc1.yaml
vi svc1.yaml, rename the svc and set service type as NodePort
k create -f svc1.yaml
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
login to the console with admin/<password>
```
### clean up
```
cd ~/go/src/github.com/rook/cluster/examples/kubernetes/ceph
kubectl delete -f csi/rbd/storageclass-test.yaml
kubectl delete -f cluster-test.yaml
kubectl delete -f crds.yaml -f common.yaml -f operator.yaml
kubectl delete ns rook-ceph
```
### clean up
### 编辑下面四个文件，将finalizer的值修改为null
### 例如
```
finalizers:
    - ceph.rook.io/disaster-protection/
```
### 修改为
```
finalizers：null
```
```
kubectl edit secret -n rook-ceph
kubectl edit configmap -n rook-ceph
kubectl edit cephclusters -n rook-ceph
kubectl edit cephblockpools -n rook-ceph
```
### 执行下面循环，直至找不到任何rook关联对象。
```
for i in `kubectl api-resources | grep true | awk '{print \$1}'`; do echo $i;kubectl get $i -n rook-ceph; done

rm -rf /var/lib/rook
```
