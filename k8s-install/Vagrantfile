# -*- mode: ruby -*-
# vi: set ft=ruby :

# 使用方法
# 1. 安装 virtualbox
# 2. 安装 vagrant
# 3. 添加镜像（可选，适用于网络不好的状况）
# 4. vagrant up
# 5. vagrant ssh 即可（默认用户名 vagrant，有 sudo 执行权限）

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false
  config.vm.network "private_network", ip: "192.168.34.2", name: "vboxnet0"

  config.vm.provider "virtualbox" do |vb|
    # 配置虚拟机为 4 个核心，6GB 内存
    vb.cpus = 4
    vb.memory = "6144"
  end
  config.vm.provision "shell", inline: <<-SHELL
    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    apt-get update
    apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
    curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
      "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    echo "deb https://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
    curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-get install -y kubelet=1.19.15-00 kubeadm=1.19.15-00 kubectl=1.19.15-00
    apt-mark hold kubelet kubeadm kubectl
    adduser vagrant docker
  SHELL
end
