install operator-sdk
install helm-operator
install kustomize
operator-sdk-1.0 init --plugins=helm --domain=com --group=example --version=v1alpha1 --kind=Nginx
make install
```
/usr/local/bin/kustomize build config/crd | kubectl apply -f -
```
```
helm-operator run
```
