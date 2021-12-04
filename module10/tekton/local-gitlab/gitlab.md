## Create tekton gitlab pipeline

```sh
kubectl apply -f gitlab-pipeline.yaml
```

## Create gitlab deploy

```sh
kubectl create -f gitlab-deploy.yaml
```

## Config gitlab

### Get root password

```sh
kubectl get po -l run=gitlab
kubectl exec -it <podname> grep 'Password:' /etc/gitlab/initial_root_password
```

### Access gitlab portal, and register a user cncamp

```sh
kubectl get svc gitlab, check nodeport and access the portal via
http://192.168.34.2:<nodeport>
```

### Login to gitlab with credential

`root/<password>`

### Change admin settings

Via http://192.168.34.2:30370/admin/application_settings/network.

Or browse `menu->admin area->network->outbound request` and tick `Allow requests to the local network from web hooks and services`

### Create a new project named test

### Create webhook

- Go to http://192.168.34.2:30370/root/test
- Browse `settings->webhook`
- Enter http://el-gitlab-listener:8080, and secret token as `1234567` and click `add webhook`

### Test webhook

Test->Push Event
`kubectl get po`, you shall see the taskrun pod
`kubectl logs --all-containers -f <podname>`
