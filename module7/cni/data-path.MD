### enter centos pod
```
k exec -it centos-5fdd4bb694-7cgc8 bash
```
### check ip and route
```
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eth0@if48: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default
    link/ether 16:4c:ec:e4:3a:d6 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.119.78/32 brd 192.168.119.78 scope global eth0
       valid_lft forever preferred_lft forever

ip r
default via 169.254.1.1 dev eth0
169.254.1.1 dev eth0 scope link
```
### check who is 169.254.1.1
```
arping 169.254.1.1
ARPING 169.254.1.1 from 192.168.119.78 eth0
Unicast reply from 169.254.1.1 [EE:EE:EE:EE:EE:EE]  0.579ms
Unicast reply from 169.254.1.1 [EE:EE:EE:EE:EE:EE]  0.536ms
```
### tcp dump on one device and test ping
### exit container and check ip a
```
ip a
45: calie3f1daf7d15@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netnsid 11
    inet6 fe80::ecee:eeff:feee:eeee/64 scope link
       valid_lft forever preferred_lft forever
```
### check ip pool config
```
k get ippool -oyaml default-ipv4-ippool
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

### check ip address
```
ip a
9: vxlan.calico: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default
link/ether 66:4e:21:17:59:aa brd ff:ff:ff:ff:ff:ff
inet 192.168.119.64/32 scope global vxlan.calico
valid_lft forever preferred_lft forever
inet6 fe80::644e:21ff:fe17:59aa/64 scope link
valid_lft forever preferred_lft forever
```
### check ip route
```
ip r
blackhole 192.168.119.64/26 proto 80
```
### check bird config
```
k exec -it calico-node-7hmbt -n calico-system cat /etc/calico/confd/config/bird.cfg
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
```
-A cali-nat-outgoing -m comment --comment "cali:flqWnvo8yq4ULQLa" -m set --match-set cali40masq-ipam-pools src -m set ! --match-set cali40all-ipam-pools dst -j MASQUERADE --random-fully
```

