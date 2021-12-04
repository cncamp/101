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

### Add insecure registry to docker client and restart docker

```json
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
  "insecure-registries": ["core.harbor.domain:32177"]
}
```

### Docker login

```sh
docker login -u harbor_registry_user -p harbor_registry_password core.harbor.domain:32083
```

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
