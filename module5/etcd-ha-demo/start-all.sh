#
# each etcd instance name need to be unique
# x380 is for peer communication
# x379 is for client communication
# dir-data cannot be shared
#
nohup etcd --name infra0 \
--data-dir=/tmp/etcd/infra0 \
--listen-peer-urls https://127.0.0.1:3380 \
--initial-advertise-peer-urls https://127.0.0.1:3380 \
--listen-client-urls https://127.0.0.1:3379 \
--advertise-client-urls https://127.0.0.1:3379 \
--initial-cluster-token etcd-cluster-1 \
--initial-cluster infra0=https://127.0.0.1:3380,infra1=https://127.0.0.1:4380,infra2=https://127.0.0.1:5380 \
--initial-cluster-state new \
--client-cert-auth --trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem \
--peer-client-cert-auth --peer-trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--peer-cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--peer-key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem 2>&1 > /var/log/infra0.log &

nohup etcd --name infra1 \
--data-dir=/tmp/etcd/infra1 \
--listen-peer-urls https://127.0.0.1:4380 \
--initial-advertise-peer-urls https://127.0.0.1:4380 \
--listen-client-urls https://127.0.0.1:4379 \
--advertise-client-urls https://127.0.0.1:4379 \
--initial-cluster-token etcd-cluster-1 \
--initial-cluster infra0=https://127.0.0.1:3380,infra1=https://127.0.0.1:4380,infra2=https://127.0.0.1:5380 \
--initial-cluster-state new \
--client-cert-auth --trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem \
--peer-client-cert-auth --peer-trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--peer-cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--peer-key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem 2>&1 > /var/log/infra1.log &

nohup etcd --name infra2 \
--data-dir=/tmp/etcd/infra2 \
--listen-peer-urls https://127.0.0.1:5380 \
--initial-advertise-peer-urls https://127.0.0.1:5380 \
--listen-client-urls https://127.0.0.1:5379 \
--advertise-client-urls https://127.0.0.1:5379 \
--initial-cluster-token etcd-cluster-1 \
--initial-cluster infra0=https://127.0.0.1:3380,infra1=https://127.0.0.1:4380,infra2=https://127.0.0.1:5380 \
--initial-cluster-state new \
--client-cert-auth --trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem \
--peer-client-cert-auth --peer-trusted-ca-file=/tmp/etcd-certs/certs/ca.pem \
--peer-cert-file=/tmp/etcd-certs/certs/127.0.0.1.pem \
--peer-key-file=/tmp/etcd-certs/certs/127.0.0.1-key.pem 2>&1 > /var/log/infra2.log &