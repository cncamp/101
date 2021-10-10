### 在 cgroup cpu 子系统目录中创建目录结构
```
cd /sys/fs/cgroup/cpu
mkdir cpudemo
cd cpudemo
```
### 运行 busyloop
### 执行 top 查看 CPU 使用情况，CPU 占用 200%
### 通过 cgroup 限制 cpu
```
cd /sys/fs/cgroup/cpu/cpudemo
```
### 把进程添加到 cgroup 进程配置组
```
echo ps -ef|grep busyloop|grep -v grep|awk '{print $2}' > cgroup.procs
```
### 设置 cpuquota
```
echo 10000 > cpu.cfs_quota_us
```
### 执行 top 查看 CPU 使用情况，CPU 占用变为10%

