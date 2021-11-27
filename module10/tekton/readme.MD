### setup tekton
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml
```
### setup tekton cli tkn
```
curl -LO https://github.com/tektoncd/cli/releases/download/v0.20.0/tektoncd-cli-0.20.0_Linux-64bit.deb
sudo dpkg -i ./tektoncd-cli-0.20.0_Linux-64bit.deb
which tkn
```

