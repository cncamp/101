clusterctl generate cluster capi-quickstart --flavor development \
  --kubernetes-version v1.22.2 \
  --control-plane-machine-count=1 \
  --worker-machine-count=1 \
  > capi-quickstart.yaml
