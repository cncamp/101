### install 
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
### access argocd 
### update argocd-server service to NodePort
#### access argocd console
```
user：admin
password： k get secret -n argocd argocd-initial-admin-secret -oyaml
```
### manage repositories->connect repo using https
```
https://github.com/cncamp/test.git
```
### create application
```
sync policy: manual
path: .
```
### create sync
### scale the deploy by cmd
```
k scale deployment httpserver --replicas=2
```
### check appstatus and sync again
### change the sync policy to auto and see
