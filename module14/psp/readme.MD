### Prepare

```sh
kubectl create namespace psp-example
kubectl create serviceaccount -n psp-example fake-user
kubectl create rolebinding -n psp-example fake-editor --clusterrole=edit --serviceaccount=psp-example:fake-user
```

### Create alias to simulate users

```sh
alias kubectl-admin='kubectl -n psp-example'
alias kubectl-user='kubectl --as=system:serviceaccount:psp-example:fake-user -n psp-example'
```

### Create psp

```sh
kubectl-admin create -f example-psp.yaml
```

### Try pod creation will fail as the psp admit is not passed

```sh
kubectl-user create -f- <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pause
spec:
  containers:
    - name: pause
      image: k8s.gcr.io/pause
EOF
```

### Check permission

```sh
kubectl-user auth can-i use podsecuritypolicy/example
```

### Create a role which use the psp

```sh
kubectl-admin create role psp:unprivileged \
    --verb=use \
    --resource=podsecuritypolicy \
    --resource-name=example
```

### Bind the role to user

```sh
kubectl-admin create rolebinding fake-user:psp:unprivileged \
    --role=psp:unprivileged \
    --serviceaccount=psp-example:fake-user
```

### Create the pod again

```sh
kubectl-user create -f- <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pause
spec:
  containers:
    - name: pause
      image: k8s.gcr.io/pause
EOF
```

### Clean up

```sh
kubectl delete psp example
kubectl delete ns psp-example
```
