node 'default' {

include vagrant

  Yumrepo <| |> -> Package <| provider != 'rpm' |>

#  $omd_site = 'test'
#  include omd::install
#  include omd::site::add

  class {'yum':
    extrarepo => ['omd','epel','puppetlabs',]
  }

  if $hostname == 'puppet' {
    package { 'puppet-server': ensure => installed, }
    class { 'puppetdb':
      node_purge_ttl => '2d',
      node_ttl       => '2d',
    }
    class { 'puppetdb::master::config': 
      restart_puppet => false,
    }
    service {'puppetmaster':
      ensure => running,
      enable => true,
    }

    Ini_setting{
      section => 'main',
      path    => '/etc/puppet/puppet.conf',
      ensure  => present,
    }
    ini_setting { 'puppet.conf/main/modulepath':
      setting => 'modulepath',
     value   => '/vagrant/modules',
    }
    ini_setting { 'puppet.conf/main/manifestdir':
      setting => 'manifestdir',
      value   => '/vagrant/manifests',
    }
#    Ini_setting{
#      section => 'agent',
#      path    => '/etc/puppet/puppet.conf',
#      ensure  => present,
#    }
    ini_setting { 'puppet.conf/main/server':
      setting => 'server',
      value   => 'puppet.example.com',
    }
  }
}
