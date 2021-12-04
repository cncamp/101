### deploy toolbox
```
kubectl create ns sidecar
kubectl label ns sidecar istio-injection=enabled
kubectl apply -f nginx.yaml -n sidecar
kubectl apply -f toolbox.yaml -n sidecar
```

### check clusters
```
kubectl get po -n sidecar
istioctl pc cluster -n sidecar toolbox-68f79dd5f8-hkgkl
```
### check toolbox sidecar logs and we can see the traffic is sent to the pod ip 
```
k logs -f toolbox-68f79dd5f8-hkgkl -n sidecar -c istio-proxy
```

