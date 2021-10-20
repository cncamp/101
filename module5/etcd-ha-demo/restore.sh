export ETCDCTL_API=3
etcdctl snapshot restore snapshot.db \
  --name infra0 \
  --data-dir=/tmp/etcd/infra0 \
  --initial-cluster infra0=http://127.0.0.1:3380,infra1=http://127.0.0.1:4380,infra2=http://127.0.0.1:5380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-advertise-peer-urls http://127.0.0.1:3380
