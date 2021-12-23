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
repo: github.com/cncamp/demo-operator
version: "3"
```
### create API, create resource[Y], create controller[Y]
```
kubebuilder create api --group apps --version v1beta1 --kind MyDaemonset
```
### open project by IDE and edit api/v1alpha1/simplestatefulset_types.go
```
// MyDaemonsetSpec defines the desired state of MyDaemonset
type MyDaemonsetSpec struct {
	// INSERT ADDITIONAL SPEC FIELDS - desired state of cluster
	// Important: Run "make" to regenerate code after modifying this file

	// Foo is an example field of MyDaemonset. Edit mydaemonset_types.go to remove/update
	Image string `json:"image,omitempty"`
}

// MyDaemonsetStatus defines the observed state of MyDaemonset
type MyDaemonsetStatus struct {
	AvaiableReplicas int `json:"avaiableReplicas,omitempty"`
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

### edit controllers/mydaemonset_controller.go  Add permissions to the controller
```
//+kubebuilder:rbac:groups=apps.cncamp.io,resources=mydaemonsets/finalizers,verbs=update
// Add the following
//+kubebuilder:rbac:groups=core,resources=nodes,verbs=get;list;watch
//+kubebuilder:rbac:groups=core,resources=pods,verbs=get;list;watch;create;update;patch;delete
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
kubebuilder create webhook --group apps --version v1beta1 --kind MyDaemonset --defaulting --programmatic-validation
```
### change code
### enable webhook in
```
config/default/kustomization.yaml
```
### redeploy