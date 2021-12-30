### Edit apiserver parameter

```sh
vi /etc/kubernetes/manifests/kube-apiserver.yaml
```

### Add the following in args, and wait for api to come back

```sh
--enable-admission-plugins=PodSecurityPolicy
```
