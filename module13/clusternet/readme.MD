## install kubectl clusternet plugin
### install krew
```
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

```
### setup krew
```
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew
```
### install clusternet plugin
```
kubectl krew update
kubectl krew install clusternet
kubectl clusternet version
```
## setup clusternet control plane
### parent cluster
```
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml
```
### child cluster, registrationToken is installed in kube-system
```
helm install clusternet-agent -n clusternet-system --create-namespace \
--set parentURL=https://192.168.34.2:6443 \
--set registrationToken=07401b.f395accd246ae52d \
clusternet/clusternet-agent
```
### check managed clusters
```
kubectl get managedcluster -A
```
### create deployment in host cluster
```
kubectl clusternet apply -f deployment.yaml
```
### where the object being stored, as manifest object in clusternet-reserved
```
k get manifest -A
NAMESPACE             NAME                       AGE
clusternet-reserved   deployments-foo-my-nginx   9h
clusternet-reserved   namespaces-foo             9h
```
### link the deployment and target cluster
```
kubectl clusternet apply -f subscription.yaml
```
### check generated obj
```
k get base -A
NAMESPACE          NAME       AGE
clusternet-bmqv4   app-demo   9h

k get description -A
NAMESPACE          NAME               DEPLOYER   STATUS    AGE
clusternet-bmqv4   app-demo-generic   Generic    Success   9h
```

