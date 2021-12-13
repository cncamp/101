### edit apiserver parameter
```
vi /etc/kubernetes/manifests/kube-apiserver.yaml
```
### add the following in args, and wait for api to come back
```
--enable-admission-plugins=PodSecurityPolicy
```
