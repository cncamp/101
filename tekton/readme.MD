### setup tekton
```
kubectl apply --filename https://github.com/cncamp/mirror/blob/master/tekton-spec/release.yaml
```
### setup tekton cli tkn
```
curl -LO https://github.com/tektoncd/cli/releases/download/v0.20.0/tektoncd-cli-0.20.0_Linux-64bit.deb
sudo dpkg -i ./tektoncd-cli-0.20.0_Linux-64bit.deb
which tkn
```
