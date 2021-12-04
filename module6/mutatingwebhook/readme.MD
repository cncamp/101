### Clone admission demo

```sh
git clone https://github.com/cncamp/admission-controller-webhook-demo.git
```

### Deploy webhook

```sh
cd admission-controller-webhook-demo/
./deploy.sh
```

### Check webhook status

```sh
k get deployment.apps/webhook-server -n webhook-demo
k get po -n webhook-demo
```

### Create demo pod and verify

```sh
kubectl create -f examples/pod-with-defaults.yaml
kubectl get po  pod-with-defaults -oyaml
kubectl logs -f pod-with-defaults
```

### More details

https://github.com/cncamp/admission-controller-webhook-demo/blob/main/README.md
