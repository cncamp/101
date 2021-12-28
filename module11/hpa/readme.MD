```sh
kubectl create -f php-apache.yaml
kubectl create -f hpav2.yaml
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
watch kubectl top pods
```
