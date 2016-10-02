# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/wily64"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 2048
    v.customize ["modifyvm", :id, "--usb", "on"]
    v.customize ["modifyvm", :id, "--usbehci", "on"]
    # fix for slow network
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  config.vm.provision "file", source: ".bash_profile", destination: "~/.bash_profile"
  config.vm.provision "file", source: "xfce4.zip", destination: "~/.config/xfce4.zip"

  config.vm.provision "shell", path: "scripts/setup.sh"

end
