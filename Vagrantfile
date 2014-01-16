# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"                                                                                                                                                                     

  config.vm.provider "virtualbox" do |v|                                                                                                                                                       
    v.memory = 1024                                                                                                                                                                            
    v.name = "beer"                                                                                                                                                                            
  end                                                                                                                                                                                          

  config.vm.define "beer" do |beer|
  end         

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"                                                                                                  

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "192.168.33.101"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.network "forwarded_port", guest: 5000, host: 5050

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.synced_folder "../", "/vagrant", id: "vagrant-root"

  # Update apt
  config.vm.provision :shell, :inline => "aptitude -q2 update && aptitude install -y python-pip"

  # add some helpful puppet modules
  # fyi: specifying '--force' means that a reprovision won't include new module dependencies,
  #      but is necessary to prevent errors when puppet tries to reinstall
  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
                  puppet module install --force thomasvandoren/redis;
                  puppet module install --force puppetlabs/nodejs;
                  puppet module install --force thias/mongodb;
                  puppet module install --force puppetlabs/vcsrepo"
  end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  config.vm.provision :puppet do |puppet|
    # puppet.module_path won't allow for the externally installed modules above :(
    puppet.options = "--verbose --debug --modulepath=/etc/puppet/modules:/vagrant/dev/puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "standalone.pp"
  end

  # Application provision
  config.vm.provision :shell, :inline => "cd /vagrant && stdbuf -o0 fab -f adsabs-fabric/fabfile.py build; exit 0"

end
