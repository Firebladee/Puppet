# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box      = "puppet"
  config.vm.box_url  = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
  config.vm.hostname = "pupp.test.com"

  # Provision via puppet.
  config.vm.provision :puppet do |puppet|

    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "site.pp"
    puppet.options        = "--verbose --debug"
#    puppet.manifests_path = "vagrant"
#    puppet.module_path    = "../"
#    puppet.manifest_file  = "site.pp"
#    puppet.options        = "--verbose --debug"
#    puppet.hiera_config_path = "hiera.yaml"
#    puppet.facter = {
#      "kap_role" => "web",
#      "kap_proj" => "eltsite",
#      "kap_envi" => "prod"
#    }
  end

  config.vm.network :forwarded_port, host:4567, guest: 80

end
