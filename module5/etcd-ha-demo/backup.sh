etcdctl --endpoints https://127.0.0.1:3379 \
--cert /tmp/etcd-certs/certs/127.0.0.1.pem \
--key /tmp/etcd-certs/certs/127.0.0.1-key.pem \
--cacert /tmp/etcd-certs/certs/ca.pem snapshot save snapshot.db
