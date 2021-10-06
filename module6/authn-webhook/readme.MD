
### start authservice
```
make build
./bin/amd64/authn-webhook
```
### create webhook config
```
mkdir -p /etc/config
cp webhook-config.json /etc/config
```
### backup old apiserver
```
cp /etc/kubernetes/manifests/kube-apiserver.yaml ~/kube-apiserver.yaml
```
### update apiserver configuration to enable webhook
```
cp specs/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```
### create a personal access token in github and put your github personal access token to kubeconfig
```
vi ~/.kube/config
- name: mfanjie
  user:
  token: <mytoken>
```
### get po by mfanjie
```
kubectl get po --user mfanjie
```
### reset the env
```
cp ~/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml 
```

