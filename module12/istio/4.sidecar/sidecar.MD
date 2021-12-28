### Deploy toolbox

```sh
kubectl create ns sidecar
kubectl label ns sidecar istio-injection=enabled
kubectl apply -f nginx.yaml -n sidecar
kubectl apply -f toolbox.yaml -n sidecar
```

### Check clusters

```sh
kubectl get po -n sidecar
istioctl pc cluster -n sidecar toolbox-68f79dd5f8-hkgkl
```

### Check tcp dump to make sure the traffic forward happen in client side(244941 is toolbox process id)

```sh
nsenter -t 244941 -n tcpdump -i eth0 -vvv port 80
```

### Or check toolbox sidecar logs and we can see the traffic is passthrough

```sh
k logs -f toolbox-68f79dd5f8-hkgkl -n sidecar -c istio-proxy
```

### Default access log format

```sh
[%START_TIME%] "%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%"
%RESPONSE_CODE% %RESPONSE_FLAGS% %BYTES_RECEIVED% %BYTES_SENT% %DURATION%
%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% "%REQ(X-FORWARDED-FOR)%" "%REQ(USER-AGENT)%"
"%REQ(X-REQUEST-ID)%" "%REQ(:AUTHORITY)%" "%UPSTREAM_HOST%"\n
```

### Data path

Client -> Server

## Client side

### Traffic is hijacked to envoy 15001 by iptables

```sh
nsenter -t 244941 -n iptables-save
---
-A OUTPUT -p tcp -j ISTIO_OUTPUT
-A ISTIO_OUTPUT -j ISTIO_REDIRECT
-A ISTIO_REDIRECT -p tcp -j REDIRECT --to-ports 15001
---
```

### Check envoy config

```sh
istioctl pc listener -n sidecar toolbox-68f79dd5f8-dcz5g --port 15001 -ojson
---
    "name": "virtualOutbound",
    "address": {
        "socketAddress": {
            "address": "0.0.0.0",
            "portValue": 15001
        }
    },
    "useOriginalDst": true
---
then it is handed over to listener 80
---

    "name": "0.0.0.0_80",
    "address": {
        "socketAddress": {
            "address": "0.0.0.0",
            "portValue": 80
        }
    },
    "routeConfigName": "80"
---
then it is handle by route 80
istioctl pc route -n sidecar toolbox-68f79dd5f8-dcz5g --name=80
---
{
                "name": "nginx.sidecar.svc.cluster.local:80",
                "domains": [
                    "nginx.sidecar.svc.cluster.local",
                    "nginx.sidecar.svc.cluster.local:80",
                    "nginx",
                    "nginx:80",
                    "nginx.sidecar.svc",
                    "nginx.sidecar.svc:80",
                    "nginx.sidecar",
                    "nginx.sidecar:80",
                    "10.109.253.161",
                    "10.109.253.161:80"
                ],
                "routes": [
                    {
                        "name": "default",
                        "match": {
                            "prefix": "/"
                        },
                        "route": {
                            "cluster": "outbound|80||nginx.sidecar.svc.cluster.local",
---
then it is handed over to cluster outbound|80||nginx.sidecar.svc.cluster.local
and the endpoint is the actual pod ip
istioctl pc endpoint -n sidecar toolbox-68f79dd5f8-dcz5g
---
192.168.166.189:80               HEALTHY     OK                outbound|80||nginx.sidecar.svc.cluster.local
---
then the request is send to kernel, going to iptables again
-A OUTPUT -p tcp -j ISTIO_OUTPUT
-A ISTIO_OUTPUT -m owner --uid-owner 1337 -j RETURN
---
iptables return and the traffic is send out!
```

### Server side is almost same but easier

iptables first, hijacked to 15006:

```sh
istioctl pc listener -n sidecar nginx-deployment-6799fc88d8-qq68n --port 15006
{
        "name": "virtualInbound",
        "address": {
            "socketAddress": {
                "address": "0.0.0.0",
                "portValue": 15006
            }
        },
---
    {
        "name": "0.0.0.0_80",
        "address": {
            "socketAddress": {
                "address": "0.0.0.0",
                "portValue": 80
            }
        },
        "filters": [
            "inbound_0.0.0.0_80"
        }
         "domains": [
                                            "*"
                                        ],
                                        "routes": [
                                            {
                                                "name": "default",
                                                "match": {
                                                    "prefix": "/"
                                                },
                                                "route": {
                                                    "cluster": "inbound|80||",
---
istioctl pc route -n sidecar nginx-deployment-6799fc88d8-qq68n --name="inbound|80||" -ojson
---
"name": "inbound|80||",
"decorator": {
    "operation": "nginx.sidecar.svc.cluster.local:80/*"
}
---
istioctl pc cluster -n sidecar nginx-deployment-6799fc88d8-qq68n
---
nginx.sidecar.svc.cluster.local                                                             80        -          outbound      EDS
---
istioctl pc endpoint -n sidecar nginx-deployment-6799fc88d8-qq68n
---
192.168.166.189:80               HEALTHY     OK                outbound|80||nginx.sidecar.svc.cluster.local
---
then it is send to kernel, handled by OUTPUT chain
-A ISTIO_OUTPUT -m owner --uid-owner 1337 -j RETURN
```
