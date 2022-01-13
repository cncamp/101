### Apply the following spec and visit bookinfo you will see timeout error with jason logon

```sh
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml
```

```
Sorry, product reviews are currently unavailable for this book.
```

### Apply the following spec and visit bookinfo you will see 5xx error

```sh
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml
```
