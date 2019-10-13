# add a repo
```
helm repo add stale http://mirror.azure.cn/kubernetes/charts/
```
# check repo list
```
helm repo list
```
search repo
```
helm search repo
```
# check versions of a chart
```
helm search repo mysql --versions
```
# create a helm chart
```
helm create helloworld
```
# install the chart
```
helm install hellow helloworld
```
# check helm installed packages/releases
```
helm list
kubectl get secret
helm upgrade hellow helloworld
```
# unstall a release
```
helm uninstall hellow
```
# release a package
```
helm package helloworld
```
# push to docker registry
```
helm chart save helloworld docker.io/mfanjie/helmcharts
```

