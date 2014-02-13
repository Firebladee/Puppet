# /etc/puppet/modules/yum/manifests/updatesd.pp

# Class yum::updatesd
#
# Installs and enables yum updatesd
#
#
class yum::updatesd {
  package { 'yum-updatesd':
    ensure => present,
    name   => $::lsbmajdistrelease ? {
      5 => 'yum-updatesd',
    },
  }

  service {'yum-updatesd':
    ensure  => running,
    enable  => true,
    require => Package['yum-updatesd'],
  }

  file {'yum-updatesd.conf':
    ensure  => present,
    path    => '/etc/yum/yum-updatesd.conf',
    source  => 'puppet:///yum/yum-updatesd.conf',
    require => Package['yum-updatesd'],
  }
}
