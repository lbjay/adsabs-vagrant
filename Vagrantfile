# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64-adsabs-vagrant-virtualbox"

#  config.vm.provider :lxc do |lxc|
#      #lxc.customize 'cgroup.memory.limit_in_bytes', '1024M'
#      lxc.name = "ads-appserver"
#  end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "https://dl.dropboxusercontent.com/s/x1085661891dhkz/lxc-centos6.5-2013-12-02.box"
  #config.vm.box_url = "https://dl.dropboxusercontent.com/s/eukkxp5mp2l5h53/lxc-centos6.4-2013-10-24.box"
  #config.vm.box_url = "http://bit.ly/vagrant-lxc-precise64-2013-10-23"
   config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
      config.vm.network :forwarded_port, guest: 8000, host: 8000
      config.vm.network :forwarded_port, guest: 5000, host: 5000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
   config.vm.synced_folder ".", "/vagrant/"
#   config.vm.synced_folder "/media/vsudilov/usbdisk", "/media/usbdisk/"


    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site.pp"
    end


end
