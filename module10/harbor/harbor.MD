### install download harbor helm chart
```
helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar
kubectl create ns harbor
```
### update values.yaml
```
vi .harbor/values.yaml and change


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
### add insecure registry to docker client and restart docker
```
{
  "features": {
    "buildkit": true
  },
  "experimental": false,
  "builder": {
    "gc": {
      "enabled": true,
      "defaultKeepStorage": "20GB"
    }
  },
  "insecure-registries": [
    "core.harbor.domain:32177"
  ]
}
```
### docker login
```
docker login -u harbor_registry_user -p harbor_registry_password core.harbor.domain:32083
```
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