### 设置 etcd 存储大小

```sh
etcd --quota-backend-bytes=$((16*1024*1024))
```

### 写爆磁盘

```sh
while [ 1 ]; do dd if=/dev/urandom bs=1024 count=1024 | ETCDCTL_API=3 etcdctl put key || break; done
```

### 查看 endpoint 状态

```sh
ETCDCTL_API=3 etcdctl --write-out=table endpoint status
```

### 查看 alarm

```sh
ETCDCTL_API=3 etcdctl alarm list
```

### 清理碎片

```sh
ETCDCTL_API=3 etcdctl defrag
```

### 清理 alarm

```sh
ETCDCTL_API=3 etcdctl alarm disarm
```
