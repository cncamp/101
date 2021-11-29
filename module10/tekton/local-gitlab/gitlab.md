## create tekton gitlab pipeline
kubectl apply -f gitlab-pipeline.yaml

## create gitlab deploy
kubectl create -f gitlab-deploy.yaml

## config gitlab
### get root password
kubectl get po -l run=gitlab
kubectl exec -it <podname> grep 'Password:' /etc/gitlab/initial_root_password
### access gitlab portal, and register a user cncamp
kubectl get svc gitlab, check nodeport and access the portal via
http://192.168.34.2:<nodeport>
### login to gitlab with credential 
root/<password>
### change admin setting via 
http://192.168.34.2:30370/admin/application_settings/network
or browse menu->admin area->network->outbound request
check `Allow requests to the local network from web hooks and services`
### create a new project
create a new project named test
### create webhook
go http://192.168.34.2:30370/root/test
browse settings->webhook
enter http://el-gitlab-listener:8080, and secret token as 1234567 and click add webhook
### test webhook
Test->Push Event
kubectl get po, you show see the taskrun pod
kubectl logs --all-containers -f <podname>