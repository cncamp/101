### 针对使用systemd拉起的服务
```
journalctl -afu kubelet -S "2019-08-26 15:00:00"
-u unit，对应的systemd拉起的组件，如kubelet
-f follow，跟踪最新日志
-a show all，现实所有日之列
-S since，从某一时间开始 -S "2019-08-26 15:00:00"
```
### 对于标准的容器日志
```
kubectl logs -f -c <containername> <podname>
kubectl logs -f --all-containers <podname>
kubectl logs -f -c <podname> --previous
```
### 如果容器日志被shell转储到文件，则需通过exec
```
kubectl exec -it xxx -- tail -f /path/to/log
```