### Download harbor helm chart

```sh
helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
kubectl create ns harbor
```

### Update values.yaml

```sh
vi .harbor/values.yaml
```

And change:

```yaml
expose:
  type: nodePort
tls:
  commonName: 'core.harbor.domain'

persistence: false
```

### Install helm chart

```sh
helm install harbor ./harbor -n harbor
```

### Wait for all pod being ready and access harbor portal

http://192.168.34.2:30002

```
admin/Harbor12345
```

### Download repository certs from

```sh
https://192.168.34.2:30003/harbor/projects/1/repositories
```

### Copy the downloaded ca.crt to vm docker certs configuration folder

```sh
mkdir /etc/docker/certs.d/core.harbor.domain
copy the ca.crt to this folder
systemctl restart docker
```

### Edit /etc/hosts to map core.harbor.domain to harbor svc clusterip

```sh
10.104.231.99 core.harbor.domain
```

### Docker login

```sh
docker login -u admin -p Harbor12345 core.harbor.domain
```

### Docker tag a image to core.harbor.domain and push it and you will see it in harbor portal

### Check repositories and blobs

```sh
kubectl exec -it harbor-registry-7d686859d7-xs5nv -n harbor bash
ls -la /storage/docker/registry/v2/repositories/
ls -la /storage/docker/registry/v2/blobs
```

### Database operator

```sh
kubectl exec -it harbor-database-0 -n harbor -- bash
psql -U postgres -d postgres -h 127.0.0.1 -p 5432
\c registry
select * from harbor_user;
\dt
```
