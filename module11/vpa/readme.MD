### clone the code
```
git clone https://github.com/kubernetes/autoscaler.git
```
### install vpa
```
cd vertical-pod-autoscaler
./hack/vpa-up.sh
```
### test vpa
```
kubectl apply -f vpa.yaml
```
### recommmender run once per min, updater run once per min
### check updater parameter for rate limit config
### updater flows
```
1. get all pods-> 
2. get live pods-> 
3. get pods managed by vpa && evictable -> 
4. add to updater queue-> 
5. if (within recommend range && no oom) || (oom but resourcediff==0) -->no update
else pods enqueue with priority-> 
6. sort by priority -> 
7. kill with ratelimit configured in command line parameter
```
