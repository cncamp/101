### easy job, create secret and refer it
```
kubectl create secret generic my-secret --from-literal=TEST_KEY="TESTVALUE"
fission fn create --name httpserver-read-secret --secret my-secret --env go --src httpserver.go --entrypoint RootHandler

fission function test --name httpserver-read-secret
```
### exec to the function pod and check
```
cat /secrets/default/my-secret/TEST_KEY
TESTVALUE
```
