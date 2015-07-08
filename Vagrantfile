# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'example.com'

puppet_nodes = [
  {:hostname => 'puppet', :ip => '172.16.32.10', :box => 'centos-65-x64-virtualbox-puppet', :fwdhost => 8140, :fwdguest => 8140, :ram => 512},
  {:hostname => 'client1', :ip => '172.16.32.11', :box => 'centos-65-x64-virtualbox-puppet', :web => 4567},
  {:hostname => 'client2', :ip => '172.16.32.12', :box => 'centos-65-x64-virtualbox-puppet', :web => 4568},
]

Vagrant.configure("2") do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/' + node_config.vm.box + '.box'
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: 8080, host:18080
      end

      if node[:web]
        node_config.vm.network :forwarded_port, guest:80, host: node[:web]
      end

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path    = 'manifests'
        puppet.module_path       = 'modules'
        puppet.manifest_file     = "site.pp"
        puppet.hiera_config_path = "hiera.yaml"
#        puppet.options        = "--verbose --debug"
      end
    end
  end
end
