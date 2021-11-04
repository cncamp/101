### Start authservice

```sh
make build
./bin/amd64/authn-webhook
```

### Create webhook config

```sh
mkdir -p /etc/config
cp webhook-config.json /etc/config
```

### Backup old apiserver

```sh
cp /etc/kubernetes/manifests/kube-apiserver.yaml ~/kube-apiserver.yaml
```

### Update apiserver configuration to enable webhook

```sh
cp specs/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```

### Create a personal access token in github and put your github personal access token to kubeconfig

```sh
vi ~/.kube/config
```

```yaml
- name: mfanjie
  user:
  token: <mytoken>
```

### Get pods by mfanjie

```sh
kubectl get po --user mfanjie
```

### Reset the env

```sh
cp ~/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```
