### apply the following spec and visit bookinfo you will see timeout error with jason logon
`Sorry, product reviews are currently unavailable for this book.`
```
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml
```

### apply the following spec and visit bookinfo you will see 5xx error
```
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml
```