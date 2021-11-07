### download helm chart and unzip
```
helm pull deliveryhero/node-problem-detector
tar -zxvf node-problem-detector-2.0.9.tgz
```
### change image
```
vi node-problem-detector/values.yaml
```
```
image:
  repository: cncamp/node-problem-detector
  tag: v0.8.10
  pullPolicy: IfNotPresent
```
### helm chart install
```
helm install npd ./node-problem-detector
```
```
sudo sh -c "echo 'kernel: BUG: unable to handle kernel NULL pointer dereference at TESTING' >> /dev/kmsg"
```
### 
