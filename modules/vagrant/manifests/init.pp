
class vagrant {

  file { '/etc/hosts':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vagrant/hosts.erb'),
  }

  if $hostname == 'puppet' {
    package { 'puppet-server': ensure => installed, }
    class { 'puppetdb':
      node_purge_ttl => '2d',
      node_ttl       => '2d',
      listen_address => '0.0.0.0',
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
    ini_setting { 'puppet.conf/main/server':
      setting => 'server',
      value   => 'puppet.example.com',
    }
  } else {
    Ini_setting{
      section => 'agent',
      path    => '/etc/puppet/puppet.conf',
      ensure  => present,
    }
    ini_setting { 'puppet.conf/main/server':
      setting => 'server',
      value   => 'puppet.example.com',
    }
  }
}
