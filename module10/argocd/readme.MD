### Install

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Access argocd

### Update argocd-server service to NodePort

#### Access argocd console

- user: `admin`
- password:
  ```sh
  k get secret -n argocd argocd-initial-admin-secret -oyaml
  ```

### Manage repositories->connect repo using https

https://github.com/cncamp/test.git

### Create application

- sync policy: `manual`
- path: `.`

### Create sync

### Scale the deploy by cmd

```sh
k scale deployment httpserver --replicas=2
```

### Check appstatus and sync again

### Change the sync policy to `auto` and check
