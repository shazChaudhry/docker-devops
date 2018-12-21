# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "bento/centos-7.4"
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.manage_guest = true
	config.vm.provision "docker"

	config.vm.define "devops1", primary: true do |devops1|
		devops1.vm.hostname = 'devops1'
		devops1.vm.network :private_network, ip: "192.168.99.201"
		devops1.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 3000]
			v.customize ["modifyvm", :id, "--name", "devops1"]
		end
		devops1.vm.provision "file", source: "~/.ssh", destination: "$HOME/.ssh"
    devops1.vm.provision "shell", inline: "chmod 600 /home/vagrant/.ssh/*"
		devops1.vm.provision "file", source: "~/.aws", destination: "$HOME/.aws"
    devops1.vm.provision "shell", inline: "chmod 600 /home/vagrant/.aws/*"
	end

	config.vm.define "devops2" do |devops2|
		devops2.vm.hostname = 'devops2'
		devops2.vm.network :private_network, ip: "192.168.99.202"
		devops2.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 3000]
			v.customize ["modifyvm", :id, "--name", "devops2"]
		end
		devops2.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"
    devops2.vm.provision "shell", inline: "cd /home/vagrant/.ssh && cat id_rsa.pub >> authorized_keys"
	end

end
