# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "windows-10"

  # Port forward WinRM and RDP
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct:true
  config.vm.communicator = "winrm"
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct:true

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :virtualbox do |v, override|
    v.gui = true
    v.name = "windows-10"
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--vram", "256"]
    v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
    v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
  end

  config.vm.provider :parallels do |v, override|
    v.name = "windows-10"
    v.customize ["set", :id, "--cpus", 2]
    v.customize ["set", :id, "--memsize", 2048]
    v.customize ["set", :id, "--videosize", "256"]
  end
end
