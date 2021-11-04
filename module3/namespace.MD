### 在新 network namespace 执行 sleep 指令：

```sh
unshare -fn sleep 60
```

### 查看进程信息

```sh
ps -ef|grep sleep
root       32882    4935  0 10:00 pts/0    00:00:00 unshare -fn sleep 60
root       32883   32882  0 10:00 pts/0    00:00:00 sleep 60
```

### 查看网络 Namespace

```sh
lsns -t net
4026532508 net       2 32882 root unassigned                                unshare
```

### 进入改进程所在 Namespace 查看网络配置，与主机不一致

```sh
nsenter -t 32882 -n ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```
