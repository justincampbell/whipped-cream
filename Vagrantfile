Vagrant.configure('2') do |config|
  config.vm.box = 'debian-wheezy'
  config.vm.box_url = 'https://dl.dropboxusercontent.com/u/86066173/debian-wheezy.box'

  [80].each do |port|
    config.vm.network "forwarded_port", guest: port, host: port
  end

  config.vm.provision :shell, inline: <<-SCRIPT
    set -x
    adduser --disabled-login pi
    echo -ne "raspberry\nraspberry\n" | passwd pi
    grep -e "^pi " /etc/sudoers ||
      echo "pi ALL=NOPASSWD:ALL" >> /etc/sudoers
  SCRIPT
end
