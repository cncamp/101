```sh
curl --key admin.key --cert admin.crt --header "Content-Type: application/json-patch+json" \
--request PATCH -k \
--data '[{"op": "add", "path": "/status/capacity/cncamp.com~1reclaimed-cpu", "value": "2"}]' \
https://192.168.34.2:6443/api/v1/nodes/cadmin/status
```
