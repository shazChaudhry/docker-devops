# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	# https://app.vagrantup.com/centos/boxes/7
	config.vm.box = "centos/7"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.manage_guest = true
	# The VirtualBox Guest Additions are not preinstalled; if you need them for shared folders,
	# please install the vagrant-vbguest (https://github.com/dotless-de/vagrant-vbguest) plugin and
	# add the following line to your Vagrantfile:
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
	# Please check the release blog for a full list of known limitations
	config.vm.provision "docker"
	config.vm.define "devops", primary: true do |devops|
		devops.vm.hostname = 'devops'
		devops.vm.network :private_network, ip: "192.168.99.201"
		devops.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 3000]
			v.customize ["modifyvm", :id, "--name", "devops"]
		end
		devops.vm.provision "file", source: "~/.ssh", destination: "$HOME/.ssh"
    devops.vm.provision "shell", inline: "chmod 600 /home/vagrant/.ssh/*"
		devops.vm.provision "file", source: "~/.aws", destination: "$HOME/.aws"
    devops.vm.provision "shell", inline: "chmod 600 /home/vagrant/.aws/*"
	end
end
