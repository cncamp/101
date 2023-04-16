
1. install fission
```
export FISSION_NAMESPACE="fission"
kubectl create namespace $FISSION_NAMESPACE
kubectl create -k "github.com/fission/fission/crds/v1?ref=v1.18.0"
helm repo add fission-charts https://fission.github.io/fission-charts/
helm repo update
helm install --version v1.18.0 --namespace $FISSION_NAMESPACE fission \
  --set serviceType=NodePort,routerServiceType=NodePort \
  fission-charts/fission-all
```
2. Install the client CLI.

Mac:
```
curl -Lo fission https://github.com/fission/fission/releases/download/v1.18.0/fission-v1.18.0-darwin-amd64 && chmod +x fission && sudo mv fission /usr/local/bin/
```

Linux:
```
curl -Lo fission https://github.com/fission/fission/releases/download/v1.18.0/fission-v1.18.0-linux-amd64 && chmod +x fission && sudo mv fission /usr/local/bin/
```

Windows:
```
For Windows, you can use the linux binary on WSL. Or you can download this windows executable: https://github.com/fission/fission/releases/download/v1.18.0/fission-v1.18.0-windows-amd64.exe
```

3. check version
```
fission version
```
```
client:
  fission/core:
    BuildDate: "2022-09-16T13:24:57Z"
    GitCommit: b36e0516
    Version: v1.17.0
server:
  fission/core:
    BuildDate: "2022-09-16T13:24:57Z"
    GitCommit: b36e0516
    Version: v1.17.0
```

4. You're ready to use Fission!

# Create an environment
```
fission env create --name nodejs --image fission/node-env
```

# Get a hello world
```
curl https://raw.githubusercontent.com/fission/examples/master/nodejs/hello.js > hello.js
```

# Register this function with Fission
```
fission function create --name hello --env nodejs --code hello.js
```

# Run this function
```
fission function test --name hello
Hello, world!
```
