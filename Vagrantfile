# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    config.vm.box_check_update = false
    config.vm.box = "ubuntu/trusty64"

    config.vm.network "private_network", ip: "192.168.10.10"
    config.vm.hostname = "wm-php7"

    config.vm.post_up_message = "Congratulations. You ok !!! \n http:\\192.168.10.10"

    config.vm.provision :shell, :path => "bootstrap.sh"

    config.vm.provision :shell,
            inline: "service nginx restart && service php7.0-fpm restart",
            run: "always"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end

    config.vm.provider "virtualbox" do |v, override|

        override.vm.synced_folder "./www", "/var/www",
            id: "www-data",
            owner: "www-data", group: "www-data",
            mount_options: ["dmode=775,fmode=664"]

        override.vm.synced_folder "./nginx/sites-enabled", "/etc/nginx/sites-enabled",
            id: "nginx",
            owner: "root", group: "root",
            mount_options: ["dmode=775,fmode=664"]

    end

end