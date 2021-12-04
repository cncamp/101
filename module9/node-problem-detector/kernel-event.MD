### Download helm chart and unzip

```sh
helm pull deliveryhero/node-problem-detector
tar -zxvf node-problem-detector-2.0.9.tgz
```

### Change image

```sh
vi node-problem-detector/values.yaml
```

```yaml
image:
  repository: cncamp/node-problem-detector
  tag: v0.8.10
  pullPolicy: IfNotPresent
```

### Install helm chart

```sh
helm install npd ./node-problem-detector
```

```sh
sudo sh -c "echo 'kernel: BUG: unable to handle kernel NULL pointer dereference at TESTING' >> /dev/kmsg"
```
