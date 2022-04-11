# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "tofino-model-dev"

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2004"
  config.vm.hostname = "tofino-model-dev"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Shares the work directory, presently containing our example.
  config.vm.synced_folder "./work", "/home/vagrant/work"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "8192" # Model requires minimum of 8GB
    vb.name = "tofino-model-dev"
  end

  
  # config.vm.network "private_network", ip: "10.0.0.10", virtualbox__intnet: "vboxnet0"
  # config.vm.network "private_network", ip: "10.0.0.11", virtualbox__intnet: "vboxnet0"


  # Add bridged network ports; replace the bridged interface for the desired
  # host interface with which to bridge.
  # config.vm.network "public_network", ip: "10.0.0.10", bridge: "enp4s0"
  # config.vm.network "public_network", ip: "10.0.0.11", bridge: "enp4s0"

  # Forwarded port to serve documentation.
  config.vm.network "forwarded_port", guest: 80, host: 4000, host_ip: '127.0.0.1'
  


  # View the documentation for the provider you are using for more
  # information on available options.


  # Add some useful tools
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    apt-get update
    apt-get install -y tcpdump mininet build-essential netcat mkdocs apache2 \
      xvfb jq
  SHELL

  config.vm.provision "file", source: "./provision/scripts",
      destination: "~/scripts"




  # Vagrant's copy file provisioning does not support copying in a privileged
  # way, so files need to be copied to a writeable location then handled in a
  # shell provisioner.
  config.vm.provision "file", source: "./provision/motd", destination: "/tmp/motd"
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    cp /tmp/motd /etc/motd
  SHELL


  # A basic tmux config.
  config.vm.provision "file", source: "./provision/tmux.conf",
      destination: "/home/vagrant/.tmux.conf"

  # Set up various paths and things. It is being done now rather than later,
  # despite having SDE paths in it, to avoid warnings when installing scapy as
  # a dependency to the test library.
  config.vm.provision "file", source: 'provision/apsn.env',
      destination: "/home/vagrant/.config/apsn.env"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo . \~/.config/apsn.env >> ~/.profile
  SHELL

  config.vm.provision "shell", privileged: true, path: './provision/deps.sh'



  # Builds the SDE. This has to be done before further configuring Python as
  # the installation process does weird things to the versions of grpcio,
  # causing any app to complain about a missing __internal_key property.
  config.vm.provision "file", source: "./sde/bf-sde-9.7.0.tgz",
    destination: "/tmp/bf-sde-9.7.0.tgz"
  config.vm.provision "file", source: "./provision/behavioural.yaml", 
    destination: "~/dependencies/behavioural.yaml"
  config.vm.provision "shell", privileged: false, path: './provision/sde.sh'

  config.vm.provision "shell", privileged: false, path: './provision/python.sh'



  # Documentation!
  config.vm.provision "file", source: "./docs", destination: "/tmp/docs/docs"
  config.vm.provision "file", source: "./cinder", destination: "/tmp/docs/cinder"
  config.vm.provision "file", source: "./mkdocs.yml",
      destination: "/tmp/docs/mkdocs.yml"
  
  config.vm.provision "shell", privileged: true, path: './provision/docs.sh'



end
