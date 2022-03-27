### Check calico node pod and think why

- Calico need to configure host network, and need to copy cni plugin to host, so need privileged mode
- Need host network

```sh
kubectl get po calico-node-xk4kn -n calico-system -oyaml
```

```yaml
    securityContext:
      privileged: true

  hostNetwork: true
```

### Prepare

```sh
kubectl create ns istiodemo
kubectl label ns istiodemo istio-injection=enabled
kubectl run --image nginx nginx -n istiodemo
kubectl get po -n istiodemo -oyaml
```

### Check istio injected pod

- Init requests `NET_ADMIN` capability to set iptables

```yaml
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

- Sidecar requires `runAsUser: 1337` and `runAsGroup:1337` to match the iptables rules

```yaml
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

### Linux capabilities

https://man7.org/linux/man-pages/man7/capabilities.7.html
