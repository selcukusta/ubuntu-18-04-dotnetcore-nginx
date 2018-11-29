
# -*- mode: ruby -*-
# vi: set ft=ruby :

### configuration parameters
BOX_BASE = "ubuntu/bionic64"
BOX_CPU_COUNT = 1
BOX_RAM_MB = "512"

### node configuration
NODE_IP = "172.81.81.2"
NODE_HOSTNAME = "node01"

Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = BOX_CPU_COUNT
    vb.memory = BOX_RAM_MB
  end

  config.vm.define "#{NODE_HOSTNAME}" do |node|
    node.vm.box = BOX_BASE
    node.vm.box_check_update = false
    node.vm.hostname = "#{NODE_HOSTNAME}"
    node.vm.network "private_network", ip: NODE_IP, netmask: "255.255.255.0"
    node.vm.provision "shell" do |s|
      s.path = "scripts/install.sh"
    end
  end
end