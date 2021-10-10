### 在 cgroup memory 子系统目录中创建目录结构
```
cd /sys/fs/cgroup/memory
mkdir memorydemo
cd memorydemo
```
### 运行 malloc（在linux机器make build）
### 查看内存使用情况
```
watch 'ps -aux|grep malloc|grep -v grep'
```
### 通过 cgroup 限制 memory
### 把进程添加到cgroup进程配置组
```
echo ps -ef|grep malloc |grep -v grep|awk '{print $2}' > cgroup.procs
```
### 设置 memory.limit_in_bytes
```
echo 104960000 > memory.limit_in_bytes
```
### 等待进程被 oom kill
