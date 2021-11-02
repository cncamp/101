### create a host folder
```
sudo mkdir /mnt/data
```
### create a file in the folder
```
sudo sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"
```
### check the file
```
cat /mnt/data/index.html
```
### create a pv
```
kubectl apply -f pv.yaml
```
### create a pvc
```
kubectl apply -f pvc.yaml
```
### create a pod
```
### create a pv
```
kubectl apply -f pod.yaml
```