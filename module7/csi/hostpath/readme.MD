### Create a host folder

```sh
sudo mkdir /mnt/data
```

### Create a file in the folder

```sh
sudo sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"
```

### Check the file

```sh
cat /mnt/data/index.html
```

### Create a pv

```sh
kubectl apply -f pv.yaml
```

### Create a pvc

```sh
kubectl apply -f pvc.yaml
```

### Create a pod

```sh
kubectl apply -f pod.yaml
```
