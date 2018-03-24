# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname            = "vagrant.local"
server_ip           = "192.168.10.33"

Vagrant.configure(2) do |config|

  # Development environment OS/box
  config.vm.box = "ubuntu/xenial64"

  # Map local port 8080 to VM port 80
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # IP to access VM
  config.vm.network "private_network", ip: server_ip

  # Set up default hostname
  config.vm.hostname = hostname

  # Sync current directory to "/vagrant" directory on the VM
  config.vm.synced_folder ".", "/vagrant", create: true, group: "www-data", owner: "www-data"

  config.vm.provider "virtualbox" do |vb|
    # Set VM name
    vb.name = "Vagrant LEMP"

    # Customize the amount of memory on the VM
    vb.memory = "2048"

    # Customize # of CPUs
    vb.cpus = 2

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    # If the clock gets more than 15 minutes out of sync (due to your laptop going
    # to sleep for instance) then some 3rd party services will reject requests.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Prevent VMs running on Ubuntu to lose internet connection
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provision "shell" do |s|
    s.path = "provision/setup.sh"
  end

end
