### Install istio


## istio 安装

### Istio 主要提供了以下三种安装方式，用户可以根据自己的实际需要进行选择。

- 1.使用 Istioctl 安装：istioctl 是支持多种自定义选项的的命令行工具，用户可以灵活配置，实现 Istio 组件的定制化安装。Istio 官方推荐使用该方式进行安装部署，可用于生产环境。
- 2.使用 Helm 自定义安装：这种安装方式使用 Helm charts 定义 Istio 的安装选项，目前该安装方式已被弃用。
- 3.安装独立的 Operator：该方式使用独立的 Istio operator 来安装 istio，以声明式的方式管理安装配置，目前仍处于实验阶段，不推荐在生产环境使用



#### stioctl 安装

1、使用 demo 配置文件进行安装
Istio 官方提供了针对不同场景的配置文件，这些内置的配置文件提供了对 Istio 控制平面和数据平面的定制内容。 用户可以根据实际场景选择特定的配置文件，然后结合自定义选项完成定制化安装。当前提供以下几种内置配置文件包括：

- default: 根据默认的安装选项启用组件，建议用于生产环境的部署。
- demo: 用于展示 Istio 的基本功能，支持运行 Bookinfo 应用程序和相关任务。
- minimal：使用 Istio 的流量管理功能所需的最少组件。
- remote：用于配置多集群服务网格场景下的远程集群。
- empty：不部署任何组件，可用于自定义配置的基础文件。
- preview：包含实验性功能，用于探索 Istio 新功能，但无法保证稳定性。

在选定上述配置文件之后，可以在安装 Istio 时在命令行添加一个或多个 --set <key>=<value> 选项，完成 Istio 安装插件的其他选项配置。


```sh
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.12.0
cp bin/istioctl /usr/local/bin
istioctl install --set profile=demo -y
```



### 查看自动创建sidecar 的webhook 以及启用ns 的自动注入功能
```
k  get  mutatingwebhookconfigurations istio-sidecar-injector -oyaml

kubectl label ns securesvc istio-injection=enabled
```
### Istio monitoring

- Grafana dashboard `7639`
