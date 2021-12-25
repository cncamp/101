```
### create privileged psp, and grant psp to kubernetes key components
```
kubectl apply -f templates
```

### edit apiserver parameter
```
vi /etc/kubernetes/manifests/kube-apiserver.yaml
```
### add the following in args, and wait for api to come back
```
--enable-admission-plugins=PodSecurityPolicy
