Vagrant.configure("2") do |config|
  config.vm.box = "bento/fedora-28"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", path: "pre-install.bash"  
end
