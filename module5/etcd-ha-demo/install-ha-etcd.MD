### Update your golang to 1.15+

### Install cfssl

```sh
apt install golang-cfssl
```

### Generate tls certs

```sh
mkdir /root/go/src/github.com/etcd-io
cd /root/go/src/github.com/etcd-io
```

```sh
git clone https://github.com/etcd-io/etcd.git
cd etcd/hack/tls-setup
```

### Edit req-csr.json and keep 127.0.0.1 and localhost only for single cluster setup.

```sh
vi config/req-csr.json
```

### Generate certs

```sh
export infra0=127.0.0.1
export infra1=127.0.0.1
export infra2=127.0.0.1
make
mkdir /tmp/etcd-certs
mv certs /tmp/etcd-certs
```

### Start etcd cluster member1

```sh
./start-all.sh
```

### Member list

```sh
etcdctl --endpoints https://127.0.0.1:3379 --cert /tmp/etcd-certs/certs/127.0.0.1.pem --key /tmp/etcd-certs/certs/127.0.0.1-key.pem --cacert /tmp/etcd-certs/certs/ca.pem member list
```

### Backup

```sh
./backup.sh
```

### Delete data

```sh
rm -rf /tmp/etcd
```

### Kill process

```sh
kill process of infra0 infra1 infra2
```

### Restore

```sh
./restore.sh
```
