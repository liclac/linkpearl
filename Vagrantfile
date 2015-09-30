# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

PILLAR = {
  'deployment' => {
    'username' => 'deploy',
    'run_as' => 'linkpearl',
    'root' => '/var/www/linkpearl',
  },
  'linkpearl' => {
    'db_username' => 'linkpearl',
    'db_password' => 'linkpearl',
  },
  'gem_users' => [ 'vagrant', 'linkpearl', 'deploy' ],
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Build it off a standard Debian 8.2 box
  config.vm.box = "box-cutter/debian82"
  
  # Prepare for Salt provisioning
  config.vm.synced_folder 'provisioning/salt', '/srv/salt'
  config.vm.provision :shell, inline: 'sudo mkdir -p /etc/salt && sudo touch /etc/salt/minion && sudo chown vagrant /etc/salt/minion' # Vagrant Issue #5973
  
  config.vm.define "default", primary: true do |dev|
    # Forward some ports
    dev.vm.network "forwarded_port", guest: 5000,  host: 5000   # Rails
    dev.vm.network "forwarded_port", guest: 4200,  host: 4200   # Ember
    dev.vm.network "forwarded_port", guest: 35729, host: 35729  # Ember (livereload)
    
    # Give it a private IP as well
    dev.vm.network "private_network", ip: "10.10.0.100"
    
    # Set CPU count and RAM limits
    dev.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    dev.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
    
    # Provision with Salt
    dev.vm.provision :salt do |salt|
      salt.bootstrap_options = '-F -c /tmp -P -i vagrant' # Vagrant Issue #6011, #6029
      salt.minion_config = 'provisioning/salt_minion'
      
      salt.run_highstate = true
      salt.log_level = 'info'
      salt.colorize = true
      
      salt.pillar PILLAR
    end
  end
  
  config.vm.define "melusine", autostart: false do |melusine|
    melusine.vm.network "private_network", ip: "10.10.10.20"
    
    melusine.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
    melusine.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "512"
      v.vmx["numvcpus"] = "1"
    end
    
    melusine.vm.provision :salt do |salt|
      salt.bootstrap_options = '-F -c /tmp -P -i melusine'
      salt.minion_config = 'provisioning/salt_minion'
      
      salt.run_highstate = true
      salt.log_level = 'info'
      salt.colorize = true
      
      salt.pillar PILLAR
    end
  end
end
