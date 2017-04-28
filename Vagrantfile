# -*- mode: ruby -*-
# vi: set ft=ruby :

project_name = "template"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Get rid of that pesky "stdin: is not a tty" error
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Forward SSH keys to the Guest VM
  config.ssh.forward_agent = true

  # Setup hostmanager config to update the host files
  # config.hostmanager.enabled = true
  # config.hostmanager.manage_host = true
  # config.hostmanager.ignore_private_ip = false
  # config.hostmanager.include_offline = true
  # config.vm.provision :hostmanager

  config.vm.define "#{project_name}" do |node|
      node.vm.hostname = "#{project_name}#{rand(01..99)}"
      node.vm.network :private_network, type: "dhcp"
      node.vm.box = "bento/ubuntu-16.04"
  end

  #config.vm.network "forwarded_port", guest: 8157, host: 8157
  config.vm.synced_folder ".", "/vagrant",
      :nfs => true,
      :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']

  config.vm.provider "virtualbox" do |vb|
      vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  end

  # We're going to use the shell provider to install Ansible so that we can run
  # it within the Guest VM, not outside
  config.vm.provision :shell,
      :privileged => true,
      :keep_color => true,
      :path => "vagrant_script/provision.sh"
end
