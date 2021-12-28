### Clone the code

```sh
git clone https://github.com/kubernetes/autoscaler.git
```

### Install vpa

```sh
cd vertical-pod-autoscaler
./hack/vpa-up.sh
```

### Test vpa

```sh
kubectl apply -f vpa.yaml
```

### Recommmender run once per min, updater run once per min

### Check updater parameter for rate limit config

### Updater flows

1. Get all pods->

2. Get live pods->

3. Get pods managed by vpa && evictable ->

4. Add to updater queue->

5. If `(within recommend range && no oom) || (oom but resourcediff==0)` -> no update

   else pods enqueue with priority->

6. Sort by priority ->

7. Kill with ratelimit configured in command line parameter
