### create a kubebuilder project, it requires an empty folder
```
kubebuilder init --domain cncamp.io
```

### check project layout
```
cat PROJECT
domain: cncamp.io
layout:
- go.kubebuilder.io/v3
projectName: mysts
repo: github.com/cncamp/mysts
version: "3"
```
### create API, create resource[Y], create controller[Y]
```
kubebuilder create api --group apps --version v1alpha1 --kind SimpleStatefulset
```
### open project by IDE and edit api/v1alpha1/simplestatefulset_types.go
```
// SimpleStatefulsetSpec defines the desired state of SimpleStatefulset
type SimpleStatefulsetSpec struct {
	// INSERT ADDITIONAL SPEC FIELDS - desired state of cluster
	// Important: Run "make" to regenerate code after modifying this file

	// Foo is an example field of SimpleStatefulset. Edit simplestatefulset_types.go to remove/update
	Image string `json:"image,omitempty"`
	Replicas int32 `json:"replicas,omitempty"`
}

// SimpleStatefulsetStatus defines the observed state of SimpleStatefulset
type SimpleStatefulsetStatus struct {
	AvailableReplicas string `json:"availableReplicas,omitempty"`
	// INSERT ADDITIONAL STATUS FIELD - define observed state of cluster
	// Important: Run "make" to regenerate code after modifying this file
}
```
### check Makefile
```
Build targets:
    ### create code skeletion
    manifests: generate crd
    generate: generate api functions, like deepCopy
    
    ### generate crd and install
    run: Run a controller from your host.
    install: Install CRDs into the K8s cluster specified in ~/.kube/config.
    
    ### docker build and deploy
    docker-build: Build docker image with the manager.
    docker-push: Push docker image with the manager.
    deploy: Deploy controller to the K8s cluster specified in ~/.kube/config.

```
### generate crd
```
make manifests
```
### build & install
```
make build
make docker-build
make docker-push
make deploy
```
## enable webhooks
### install cert-manager
```
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml
```
### create webhooks
```
kubebuilder create webhook --group apps --version v1alpha1 --kind SimpleStatefulset --defaulting --programmatic-validation
```
### change code
### enable webhook in
```
config/default/kustomization.yaml
```
### redeploy