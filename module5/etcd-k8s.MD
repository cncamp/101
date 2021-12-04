```sh
alias ks=kubectl -n kube-system
ks get po etcd-cadmin -oyaml
```

```yaml
spec:
  containers:
    - command:
        - etcd
        - --advertise-client-urls=https://192.168.34.2:2379
        - --cert-file=/etc/kubernetes/pki/etcd/server.crt
        - --client-cert-auth=true
        - --data-dir=/var/lib/etcd
        - --initial-advertise-peer-urls=https://192.168.34.2:2380
        - --initial-cluster=cadmin=https://192.168.34.2:2380
        - --key-file=/etc/kubernetes/pki/etcd/server.key
        - --listen-client-urls=https://127.0.0.1:2379,https://192.168.34.2:2379
        - --listen-metrics-urls=http://127.0.0.1:2381
        - --listen-peer-urls=https://192.168.34.2:2380
        - --name=cadmin
        - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
        - --peer-client-cert-auth=true
        - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
        - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
        - --snapshot-count=10000
        - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
```

```sh
ks exec -it etcd-cadmin sh
ETCDCTL_API=3
alias ectl='etcdctl --endpoints https://127.0.0.1:2379 \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key'

ectl member list

ectl get --prefix --keys-only /

ectl get /registry/services/specs/kube-system/kube-dns -w=json
{"header":{"cluster_id":10396955284310292238,"member_id":2496364209257137704,"revision":596482,"raft_term":8},"kvs":[{"key":"L3JlZ2lzdHJ5L3NlcnZpY2VzL3NwZWNzL2t1YmUtc3lzdGVtL2t1YmUtZG5z","create_revision":251,"mod_revision":251,"version":1,"value":"azhzAAoNCgJ2MRIHU2VydmljZRLfCAqbBwoIa3ViZS1kbnMSABoLa3ViZS1zeXN0ZW0iACokZTc0MmExMWYtMzY4NC00ZThkLWJhOGEtZWZiY2E2YTM0YzMwMgA4AEIICL+hx4oGEABaEwoHazhzLWFwcBIIa3ViZS1kbnNaJQoda3ViZXJuZXRlcy5pby9jbHVzdGVyLXNlcnZpY2USBHRydWVaHQoSa3ViZXJuZXRlcy5pby9uYW1lEgdDb3JlRE5TYhoKEnByb21ldGhldXMuaW8vcG9ydBIEOTE1M2IcChRwcm9tZXRoZXVzLmlvL3NjcmFwZRIEdHJ1ZXoAigGxBQoHa3ViZWFkbRIGVXBkYXRlGgJ2MSIICL+hx4oGEAAyCEZpZWxkc1YxOoMFCoAFeyJmOm1ldGFkYXRhIjp7ImY6YW5ub3RhdGlvbnMiOnsiLiI6e30sImY6cHJvbWV0aGV1cy5pby9wb3J0Ijp7fSwiZjpwcm9tZXRoZXVzLmlvL3NjcmFwZSI6e319LCJmOmxhYmVscyI6eyIuIjp7fSwiZjprOHMtYXBwIjp7fSwiZjprdWJlcm5ldGVzLmlvL2NsdXN0ZXItc2VydmljZSI6e30sImY6a3ViZXJuZXRlcy5pby9uYW1lIjp7fX19LCJmOnNwZWMiOnsiZjpjbHVzdGVySVAiOnt9LCJmOmludGVybmFsVHJhZmZpY1BvbGljeSI6e30sImY6cG9ydHMiOnsiLiI6e30sIms6e1wicG9ydFwiOjUzLFwicHJvdG9jb2xcIjpcIlRDUFwifSI6eyIuIjp7fSwiZjpuYW1lIjp7fSwiZjpwb3J0Ijp7fSwiZjpwcm90b2NvbCI6e30sImY6dGFyZ2V0UG9ydCI6e319LCJrOntcInBvcnRcIjo1MyxcInByb3RvY29sXCI6XCJVRFBcIn0iOnsiLiI6e30sImY6bmFtZSI6e30sImY6cG9ydCI6e30sImY6cHJvdG9jb2wiOnt9LCJmOnRhcmdldFBvcnQiOnt9fSwiazp7XCJwb3J0XCI6OTE1MyxcInByb3RvY29sXCI6XCJUQ1BcIn0iOnsiLiI6e30sImY6bmFtZSI6e30sImY6cG9ydCI6e30sImY6cHJvdG9jb2wiOnt9LCJmOnRhcmdldFBvcnQiOnt9fX0sImY6c2VsZWN0b3IiOnt9LCJmOnNlc3Npb25BZmZpbml0eSI6e30sImY6dHlwZSI6e319fUIAEroBChYKA2RucxIDVURQGDUiBggAEDUaACgAChoKB2Rucy10Y3ASA1RDUBg1IgYIABA1GgAoAAocCgdtZXRyaWNzEgNUQ1AYwUciBwgAEMFHGgAoABITCgdrOHMtYXBwEghrdWJlLWRucxoKMTAuOTYuMC4xMCIJQ2x1c3RlcklQOgROb25lQgBSAFoAYABoAIoBC1NpbmdsZVN0YWNrkgEKMTAuOTYuMC4xMJoBBElQdjSyAQdDbHVzdGVyGgIKABoAIgA="}],"count":1}

# 慎用
etcl delete
```
