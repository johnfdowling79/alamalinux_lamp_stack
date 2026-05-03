
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use an AlmaLinux 9 box from HashiCorp Vagrant Cloud
  config.vm.box = "almalinux/9"


  config.vbguest.auto_update = true
  config.vbguest.iso_path = "https://download.virtualbox.org/virtualbox/7.2.8/VBoxGuestAdditions_7.2.8.iso"

  config.vm.provision "shell", path: "setup.sh", run: 'once'
  config.vm.provision "shell", path: "install_mysql.sh", run: 'once'
  config.vm.provision "shell", path: "startup.sh", run: 'always'


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 80, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 3306, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 22, host: 22, host_ip: "127.0.0.1"


  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
#   config.vm.synced_folder "../data", "/www"
  config.vm.synced_folder "./www", "/var/www/html"
  config.vm.synced_folder "./config", "/mnt/config"


  # Provider-specific configuration for VirtualBox
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.name = "alamalinux_lamp_stack"
  end

end
