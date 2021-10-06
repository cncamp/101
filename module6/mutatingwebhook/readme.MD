### clone admission demo
```
git clone https://github.com/cncamp/admission-controller-webhook-demo.git
```
###  deploy webhook
```
cd admission-controller-webhook-demo/
./deploy.sh
```
### check webhook status
```
k get deployment.apps/webhook-server -n webhook-demo
k get po -n webhook-demo
```
### create demo pod and verify 
```
kubectl create -f examples/pod-with-defaults.yaml
kubectl get po  pod-with-defaults -oyaml
kubectl logs -f pod-with-defaults
```
