minikube start \
    --cpus=8 \
    --v=4 \
    --memory=8192 \
    --network-plugin=cni \
    --enable-default-cni \
    --bootstrapper=kubeadm \
    --kubernetes-version v1.18.3 \
    --image-mirror-country=cn \
    --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers