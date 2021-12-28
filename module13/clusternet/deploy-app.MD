### Create deployment in host cluster

```sh
kubectl clusternet apply -f deployment.yaml
```

### Where the object being stored, as manifest object in clusternet-reserved

```sh
k get manifest -A
NAMESPACE             NAME                       AGE
clusternet-reserved   deployments-foo-my-nginx   9h
clusternet-reserved   namespaces-foo             9h
```

### Link the deployment and target cluster

```sh
kubectl apply -f localization.yaml
kubectl apply -f subscription.yaml
```

### Check generated obj

```sh
k get base -A
NAMESPACE          NAME       AGE
clusternet-bmqv4   app-demo   9h

k get description -A
NAMESPACE          NAME               DEPLOYER   STATUS    AGE
clusternet-bmqv4   app-demo-generic   Generic    Success   9h
```

```sh
etcdctl --endpoints https://127.0.0.1:2379 \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key \
```
