### nodefs:
#### containerd
`/var/lib/kubelet/pods/ecbbaf5e-c7f1-4f00-8627-454f03cfbb4d`

### imagefs:

#### containerd
`/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs`
#### docker
`/var/lib/docker/overlay2/`


### eviction configuration
```
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
evictionHard:
  memory.available: "500Mi"
  nodefs.available: "1Gi"
  imagefs.available: "100Gi"
evictionMinimumReclaim:
  memory.available: "0Mi"
  nodefs.available: "500Mi"
  imagefs.available: "2Gi"
```