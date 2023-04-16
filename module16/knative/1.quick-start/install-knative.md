1. install serving
```
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.3/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.3/serving-core.yaml
```
2. install networking (istio)
```
kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-v1.8.1/istio.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.8.1/istio.yaml
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v1.8.1/net-istio.yaml
kubectl --namespace istio-system get service istio-ingressgateway
```
3. config dns, Knative Serving to use sslip.io as the default DNS suffix.
```
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.3/serving-default-domain.yaml
```
4. hpa 
```
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.3/serving-hpa.yaml
```
5. install eventing
```
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.8.5/eventing-crds.yaml
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.8.5/eventing-core.yaml
```
6. install kafka
```
kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-v1.8.6/eventing-kafka-controller.yaml
kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-v1.8.6/eventing-kafka-channel.yaml
```
7. install func cli
```
brew tap knative-sandbox/kn-plugins
brew install func
brew install knative/client/kn
```