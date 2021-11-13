### Enter centos pod

```shell
$ k exec -it centos-5fdd4bb694-7cgc8 bash
```

### Check ip and route

```shell
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eth0@if48: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default
    link/ether 16:4c:ec:e4:3a:d6 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.119.78/32 brd 192.168.119.78 scope global eth0
       valid_lft forever preferred_lft forever

$ ip r
default via 169.254.1.1 dev eth0
169.254.1.1 dev eth0 scope link
```

### Check who is 169.254.1.1

```shell
$ arping 169.254.1.1
ARPING 169.254.1.1 from 192.168.119.78 eth0
Unicast reply from 169.254.1.1 [EE:EE:EE:EE:EE:EE]  0.579ms
Unicast reply from 169.254.1.1 [EE:EE:EE:EE:EE:EE]  0.536ms
```

### tcpdump on one device and test ping

### Exit container and check ip a

```shell
$ ip a
45: calie3f1daf7d15@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netnsid 11
    inet6 fe80::ecee:eeff:feee:eeee/64 scope link
       valid_lft forever preferred_lft forever
```

### Check ip pool config

```shell
$ k get ippool -oyaml default-ipv4-ippool
apiVersion: projectcalico.org/v3
kind: IPPool
metadata:
  name: default-ipv4-ippool
spec:
  blockSize: 26
  cidr: 192.168.0.0/16
  ipipMode: Never
  natOutgoing: true
  nodeSelector: all()
  vxlanMode: CrossSubnet
```

### Check ip address

```shell
$ ip a
9: vxlan.calico: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default
link/ether 66:4e:21:17:59:aa brd ff:ff:ff:ff:ff:ff
inet 192.168.119.64/32 scope global vxlan.calico
valid_lft forever preferred_lft forever
inet6 fe80::644e:21ff:fe17:59aa/64 scope link
valid_lft forever preferred_lft forever
```

### Check ip route

```shell
$ ip r
blackhole 192.168.119.64/26 proto 80
```

### In multiple node env

```sh
ipamblock:
10-233-90-0-24
node1
cidr: 10.233.90.0/24

10.233.96.0/24 via 192.168.34.11 dev tunl0 proto bird onlink

ipamblock:
10-233-96-0-24
node: node2
cidr: 10.233.96.0/24
10.233.90.0/24 via 192.168.34.10 dev tunl0 proto bird onlink
```

### Check network mode

```shell
$ k get po -n calico-system calico-node-xk4kn -oyaml
    - name: CALICO_NETWORKING_BACKEND
      value: bird
    name: calico-node
    readinessProbe:
      exec:
        command:
        - /bin/calico-node
        - -bird-ready
        - -felix-ready
      failureThreshold: 3
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 5
```

### Check bird process running on the host

```shell
$ ps -ef|grep bird
root        2433    2386  0 10:58 ?        00:00:00 runsv bird
root        2435    2386  0 10:58 ?        00:00:00 runsv bird6
root        2505    2469  0 10:58 ?        00:00:00 svlogd -ttt /var/log/calico/bird6
root        2516    2510  0 10:58 ?        00:00:00 svlogd -ttt /var/log/calico/bird
root        3662    2433  0 10:58 ?        00:00:00 bird -R -s /var/run/calico/bird.ctl -d -c /etc/calico/confd/config/bird.cfg
root        3664    2435  0 10:58 ?        00:00:00 bird6 -R -s /var/run/calico/bird6.ctl -d -c /etc/calico/confd/config/bird6.cfg
root        9167    5788  0 11:05 pts/0    00:00:00 grep --color=auto bird
```

### Check bird config

```shell
$ k exec -it calico-node-7hmbt -n calico-system cat /etc/calico/confd/config/bird.cfg

router id 192.168.34.2;

protocol direct {
  debug { states };
  interface -"cali*", -"kube-ipvs*", "*"; # Exclude cali* and kube-ipvs* but
                                          # include everything else.  In
                                          # IPVS-mode, kube-proxy creates a
                                          # kube-ipvs0 interface. We exclude
                                          # kube-ipvs0 because this interface
                                          # gets an address for every in use
                                          # cluster IP. We use static routes
                                          # for when we legitimately want to
                                          # export cluster IPs.
}
```

### iptables-save, masq all traffic to outside

```sh
-A cali-nat-outgoing -m comment --comment "cali:flqWnvo8yq4ULQLa" -m set --match-set cali40masq-ipam-pools src -m set ! --match-set cali40all-ipam-pools dst -j MASQUERADE --random-fully
```
