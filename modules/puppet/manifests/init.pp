# /etc/puppet/modules/puppet/manifests/init.pp

class puppet {

  file { '/etc/puppet/puppet.conf':
    ensure => present,
    mode   => 0644,
    owner  => root,
    group  => root,
    source => 'puppet:///puppet/puppet.conf',
  }

  if $::virtual == 'virtualbox' {
    file { '/etc/puppet/hiera.yaml':
      ensure => present,
      mode   => 0644,
      owner  => root,
      group  => root,
      source => 'puppet:///modules/puppet/hiera.yaml',
    }
  }
}
