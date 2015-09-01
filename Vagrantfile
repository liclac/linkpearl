# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Build it off an Ubuntu 14.04 x64 box with Puppet preinstalled
  # config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.box = "debian/jessie64"
  
  # Forward some ports
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  
  # Set CPU count and RAM limits
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "2"
  end
  
  # Provision with Salt
  config.vm.synced_folder 'provisioning/salt', '/srv/salt'
  config.vm.provision :shell, inline: 'sudo mkdir -p /etc/salt && sudo touch /etc/salt/minion && sudo chown vagrant /etc/salt/minion' # Vagrant Issue #5973
  config.vm.provision :salt do |salt|
    salt.bootstrap_options = '-F -c /tmp -P' # Vagrant Issue #6011, #6029
    
    salt.minion_config = 'provisioning/salt_minion'
    salt.minion_id = 'vagrant'
    
    salt.run_highstate = true
    salt.log_level = 'info'
    
    salt.pillar({
      'linkpearl' => {
        'username' => 'vagrant',
        'db_username' => 'vagrant',
        'db_password' => 'linkpearl',
      }
    })
  end
end
