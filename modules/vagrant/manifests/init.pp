
class vagrant {

  file { '/etc/hosts':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vagrant/hosts.erb'),
  }

#  if ($hostname == 'puppet') and ($clientversion < '4') {
#    $package = 'puppet-server'
#    $server = 'puppetmaster'
#    $path = '/etc/puppet'
#    $module = 'modulepath'
#  }
#  else {
#    $package = 'puppetserver'
#    $server = 'puppetserver'
#    $path = '/etc/puppetlabs/puppet'
#    $module = 'basemodulepath'
#  }

#  if $hostname == 'puppet' {
#    package { $package :
#      ensure => installed,
#    }

#    class { 'puppetdb':
#      node_purge_ttl => '2d',
#      node_ttl       => '2d',
#      listen_address => '0.0.0.0',
#    }
#    class { 'puppetdb::master::config':
#      restart_puppet => false,
#    }
#    service { $server :
#      ensure  => running,
#      enable  => true,
#      require => Package[$package],
#    }

#    Ini_setting{
#      section => 'main',
#      path    => "${path}/puppet.conf",
#      ensure  => present,
#    }
#    ini_setting { 'puppet.conf/main/modulepath':
#      setting => $module,
#      value   => '/vagrant/modules',
#    }
#    ini_setting { 'puppet.conf/main/manifestdir':
#      setting => 'manifestdir',
#      value   => '/vagrant/manifests',
#    }
#    ini_setting { 'puppet.conf/main/server':
#      setting => 'server',
#      value   => 'puppet.example.com',
#    }
#    if $::virtual == 'virtualbox' {
#      file { "${path}/hiera.yaml":
#        ensure => present,
#        mode   => '0644',
#        owner  => root,
#        group  => root,
#        source => 'puppet:///modules/vagrant/hiera.yaml',
#      }
#    }
#  } else {
#    Ini_setting{
#      section => 'agent',
#      path    => "${path}/puppet.conf",
#      ensure  => present,
#    }
#    ini_setting { 'puppet.conf/main/server':
#      setting => 'server',
#      value   => 'puppet.example.com',
#    }
#  }
}
