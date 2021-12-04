```sh
ks exec -it kube-controller-manager-cadmin -- kube-controller-manager -h
```

```
Nodelifecycle controller flags:

      --enable-taint-manager
                WARNING: Beta feature. If set to true enables NoExecute Taints and will evict all not-tolerating Pod running on
                Nodes tainted with this kind of Taints. (default true)
      --large-cluster-size-threshold int32
                Number of nodes from which NodeController treats the cluster as large for the eviction logic purposes.
                --secondary-node-eviction-rate is implicitly overridden to 0 for clusters this size or smaller. (default 50)
      --node-eviction-rate float32
                Number of nodes per second on which pods are deleted in case of node failure when a zone is healthy (see
                --unhealthy-zone-threshold for definition of healthy/unhealthy). Zone refers to entire cluster in non-multizone
                clusters. (default 0.1)
      --node-monitor-grace-period duration
                Amount of time which we allow running Node to be unresponsive before marking it unhealthy. Must be N times more
                than kubelet's nodeStatusUpdateFrequency, where N means number of retries allowed for kubelet to post node status.
                (default 40s)
      --node-startup-grace-period duration
                Amount of time which we allow starting Node to be unresponsive before marking it unhealthy. (default 1m0s)
      --pod-eviction-timeout duration
                The grace period for deleting pods on failed nodes. (default 5m0s)
      --secondary-node-eviction-rate float32
                Number of nodes per second on which pods are deleted in case of node failure when a zone is unhealthy (see
                --unhealthy-zone-threshold for definition of healthy/unhealthy). Zone refers to entire cluster in non-multizone
                clusters. This value is implicitly overridden to 0 if the cluster size is smaller than
                --large-cluster-size-threshold. (default 0.01)
      --unhealthy-zone-threshold float32
                Fraction of Nodes in a zone which needs to be not Ready (minimum 3) for zone to be treated as unhealthy.  (default 0.55)
```
