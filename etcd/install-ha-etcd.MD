### copy etcd from container to host
```
docker ps|grep etcd
```
```
docker cp 88231e147e48:/usr/local/bin/etcd /usr/local/bin
```
### install cfssl
```
apt install golang-cfssl
```
### generate tls certs
```
mkdir /root/go/src/github.com/etcd-io
cd /root/go/src/github.com/etcd-io
```
```
git clone https://github.com/etcd-io/etcd.git
```
```
cd etcd/hack/tls-setup/
```
### edit req-csr.json and keep 127.0.0.1 and localhost only for single cluster setup.
```
vi req-csr.json
```
### generate certs
```
export infra0=127.0.0.1
export infra1=127.0.0.1
export infra2=127.0.0.1
make
mkdir /tmp/etcd-certs
mv certs /tmp/etcd-certs
```
### start etcd cluster member1
```
./start-infra0.sh
./start-infra1.sh
./start-infra0.sh
```
