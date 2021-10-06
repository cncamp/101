### 创建工作目录
```
mkdir -p /data/k8s-work 
cd /data/k8s-work
```
### 下载cfssl工具
```
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64

chmod +x cfssl*
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
mv cfssl-certinfo_linux-amd64 /usr/local/bin/cfssl-certinfo
```
### 生成ca配置文件
```
cat > ca-csr.json <<"EOF"
{
"CN": "kubernetes",
"key": {
"algo": "rsa",
"size": 2048
},
"names": [
{
"C": "CN",
"ST": "Shanghai",
"L": "Shanghai",
"O": "cncamp",
"OU": "cncamp"
}
],
"ca": {
"expiry": "87600h"
}
}
EOF
```
### 生成ca证书文件
```
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
```
### 配置ca证书策略
```
cat > ca-config.json <<"EOF"
{
  "signing": {
      "default": {
          "expiry": "87600h"
        },
      "profiles": {
          "kubernetes": {
              "usages": [
                  "signing",
                  "key encipherment",
                  "server auth",
                  "client auth"
              ],
              "expiry": "87600h"
          }
      }
  }
}
EOF
```
### 配置etcd请求csr文件
```
cat > etcd-csr.json <<"EOF"
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "192.168.34.2"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [{
    "C": "CN",
    "ST": "Shanghai",
    "L": "Shanghai",
    "O": "cncamp",
    "OU": "cncamp"
  }]
}
EOF
```
### 生成证书
```
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes etcd-csr.json | cfssljson  -bare etcd
```
```
wget https://github.com/etcd-io/etcd/releases/download/v3.5.0/etcd-v3.5.0-linux-amd64.tar.gz
tar -xvf etcd-v3.5.0-linux-amd64.tar.gz
cp -p etcd-v3.5.0-linux-amd64/etcd* /usr/local/bin/
```
### 生成etcd配置文件
```
cat >  etcd.conf <<"EOF"
#[Member]
ETCD_NAME="etcd1"
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="https://192.168.34.2:2380"
ETCD_LISTEN_CLIENT_URLS="https://192.168.34.2:2379,http://127.0.0.1:2379"

#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.34.2:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.34.2:2379"
ETCD_INITIAL_CLUSTER="etcd1=https://192.168.34.2:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"
EOF
```

### reference 
https://www.jianshu.com/p/b02c428950df