# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "bento/centos-7.4"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.manage_guest = true
	config.vm.provision "docker"

	config.vm.define "node1", primary: true do |node1|
		node1.vm.hostname = 'node1'
		node1.vm.network :private_network, ip: "192.168.99.101"
		node1.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 5000]
			v.customize ["modifyvm", :id, "--name", "node1"]
		end
		node1.vm.provision "file", source: "~/.ssh", destination: "$HOME/.ssh"
    node1.vm.provision "shell", inline: "chmod 600 /home/vagrant/.ssh/*"
		node1.vm.provision "file", source: "~/.aws", destination: "$HOME/.aws"
    node1.vm.provision "shell", inline: "chmod 600 /home/vagrant/.aws/*"
	end

	config.vm.define "node2" do |node2|
		node2.vm.hostname = 'node2'
		node2.vm.network :private_network, ip: "192.168.99.102"
		node2.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 3000]
			v.customize ["modifyvm", :id, "--name", "node2"]
		end
		node2.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"
    node2.vm.provision "shell", inline: "cd /home/vagrant/.ssh && cat id_rsa.pub >> authorized_keys"
	end

end
