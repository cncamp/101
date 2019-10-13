
# setup local k8s env
https://minikube.sigs.k8s.io/docs/

## install virtualbox
https://www.virtualbox.org/
## download minikube
https://github.com/kubernetes/minikube/releases
## start minikube
```
minikube start \
    --cpus 4 \
    --memory 4096 \
    --network-plugin=cni \
    --enable-default-cni \
    --bootstrapper=kubeadm \
    --kubernetes-version v1.15.4 \
    --image-mirror-country=cn \
    --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
```
# Istio Setup
# install helm 3 (must be 3 which does not need tiller)
https://github.com/helm/helm/releases
# install istio
```
git clone https://github.com/istio/istio.git
cd istio
```
```
vi install/kubernetes/helm/istio-init/values.yaml
vi install/kubernetes/helm/istio/values.yaml
```
set
```
hub: docker.io/istio
tag: 1.3.3
```
```
kubectl create ns istio-system
helm install istio-init install/kubernetes/helm/istio-init  --namespace istio-system
helm install istio install/kubernetes/helm/istio  --namespace istio-system
```
# clean up
```
kubectl delete clusterrolebinding istio-init-admin-role-binding-istio-system
kubectl delete clusterrole istio-init-istio-system
```

