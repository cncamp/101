# Setup Istio

## Download istio release

```shell
$ curl -L https://istio.io/downloadIstio | sh -
```

## Move to the Istio package directory

```shell
$ cd istio-1.6.2
```

## Add istioctl to path

```shell
$ export PATH=$PWD/bin:$PATH
```

## Install Istio

```shell
$ istioctl install --set profile=demo
```

# Manage Istio

## Enable access log

```shell
$ istioctl manifest apply --set values.global.proxy.accessLogFile="/dev/stdout"
```

## Enable mts

```shell
$ istioctl manifest apply --set values.global.mtls.enabled=true --set values.global.controlPlaneSecurityEnabled=true
```

## Enable tracing

```shell
$ istioctl manifest apply --set values.tracing.enabled=disable --set values.tracing.provider=zipkin
```
