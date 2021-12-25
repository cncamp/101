### check calico node pod and think why
- calico need to configure host network, and need to copy cni plugin to host, so need privileged mode
- need hostnetwork
```
kubectl get po calico-node-xk4kn -n calico-system -oyaml

    securityContext:
      privileged: true
  
  hostNetwork: true
```
###
```
kubectl create ns istiodemo
kubectl label ns istiodemo istio-injection=enabled
kubectl run --image nginx nginx -n istiodemo
kubectl get po -n istiodemo -oyaml
```
### check istio injected pod

- init requests NET_ADMIN capability to set iptables
```
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          add:
          - NET_ADMIN
          - NET_RAW
          drop:
          - ALL
        privileged: false
        readOnlyRootFilesystem: false
        runAsGroup: 0
        runAsNonRoot: false
        runAsUser: 0
```
- sidecar requires runas 1337 to match the iptables rules
```
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop:
          - ALL
        privileged: false
        readOnlyRootFilesystem: true
        runAsGroup: 1337
        runAsNonRoot: true
        runAsUser: 1337
```
### linux capabilities
https://man7.org/linux/man-pages/man7/capabilities.7.html