etcdctl --endpoints https://127.0.0.1:3379 \
--cert /tmp/etcd-certs/certs/127.0.0.1.pem \
--key /tmp/etcd-certs/certs/127.0.0.1-key.pem \
--cacert /tmp/etcd-certs/certs/ca.pem snapshot save snapshot1.db

etcdctl --endpoints https://127.0.0.1:4379 \
--cert /tmp/etcd-certs/certs/127.0.0.1.pem \
--key /tmp/etcd-certs/certs/127.0.0.1-key.pem \
--cacert /tmp/etcd-certs/certs/ca.pem snapshot save snapshot2.db

etcdctl --endpoints https://127.0.0.1:5379 \
--cert /tmp/etcd-certs/certs/127.0.0.1.pem \
--key /tmp/etcd-certs/certs/127.0.0.1-key.pem \
--cacert /tmp/etcd-certs/certs/ca.pem snapshot save snapshot3.db
