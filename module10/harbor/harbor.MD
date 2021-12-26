### install download harbor helm chart
```
helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
kubectl create ns harbor
```
### update values.yaml
```
vi ./harbor/values.yaml and change


expose:
  type: nodePort
tls:
  commonName: "core.harbor.domain"

persistence: false
```
### install helm chart
```
helm install harbor ./harbor -n harbor
```
### wait for all pod being ready and access harbor portal
```
192.168.34.2:30002
admin/Harbor12345
```
### download repository certs from 
```
https://192.168.34.2:30003/harbor/projects/1/repositories
```
### copy the downloaded ca.crt to vm docker certs configuration folder
```
mkdir /etc/docker/certs.d/core.harbor.domain
copy the ca.crt to this folder
systemctl restart docker
```
### edit /etc/hosts to map core.harbor.domain to harbor svc clusterip
```
10.104.231.99 core.harbor.domain
```
### docker login
```
docker login -u admin -p Harbor12345 core.harbor.domain
```
### docker tag a image to core.harbor.domain and push it and you will see it in harbor portal

### check repositories and blobs
```
kubectl exec -it harbor-registry-7d686859d7-xs5nv -n harbor bash
ls -la /storage/docker/registry/v2/repositories/
ls -la /storage/docker/registry/v2/blobs
```
### db operator
```
kubectl exec -it harbor-database-0 -n harbor bash
psql -U postgres -d postgres -h 127.0.0.1 -p 5432
\c registry
select * from harbor_user;
\dt

```