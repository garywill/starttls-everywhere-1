# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.box = "precise32"

  config.vm.define "sender" do |sender|
    sender.vm.network "private_network", ip: "192.168.33.5"
    sender.vm.hostname = "sender.example.com"
  end
  config.vm.define "valid" do |valid|
    valid.vm.network "private_network", ip: "192.168.33.7"
    valid.vm.hostname = "valid-example-recipient.com"
  end
  config.vm.synced_folder "vagrant-shared", "/vagrant"
  config.vm.synced_folder "vagrant-shared/starttls-everywhere", "/vagrant/starttls-everywhere"
  config.vm.provision :shell, path: "vagrant-bootstrap.sh"

  config.vm.provider "virtualbox" do |vb|
 #   vb.gui = true
     vb.customize ["modifyvm", :id, "--memory", "256"]
  end

end
