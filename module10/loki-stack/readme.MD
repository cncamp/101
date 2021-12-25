### add grafana repo
helm repo add grafana https://grafana.github.io/helm-charts
### install loki-stack
```
helm upgrade --install loki grafana/loki-stack --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false
```

### if you get the following error, that means your k8s version is too new to install
```
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "ClusterRole" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "ClusterRoleBinding" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "Role" in version "rbac.authorization.k8s.io/v1beta1", unable to recognize "": no matches for kind "RoleBinding" in version "rbac.authorization.k8s.io/v1beta1"]
```

### download loki-stack
```
helm pull grafana/loki-stack
tar -xvf loki-stack-*.tgz
```
```
cd loki-stack
```
### replace all `rbac.authorization.k8s.io/v1beta1` with `rbac.authorization.k8s.io/v1` by 
```
grep -rl "rbac.authorization.k8s.io/v1beta1" . | xargs sed -i 's/rbac.authorization.k8s.io\/v1beta1/rbac.authorization.k8s.io\/v1/g'
```
### install loki locally
```
helm upgrade --install loki ./loki-stack --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false
```
### change the grafana service to NodePort type and access it
```
kubectl edit svc loki-grafana -oyaml -n default
change ClusterIP type to NodePort
```
login password is in secret `loki-grafana`
```
kubectl get secret loki-grafana -oyaml -n default
```
find admin-password: xxx
```
echo 'xxx' | base64 -d
```
then you will get grafana login password, the login username is 'admin' on default.

note: the xxx is value of key  admin-password in your yaml.

###

