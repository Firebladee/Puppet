# /etc/puppet/modules/yum/manifests/prerequisites.pp

class yum::prerequisites {

  $lsbmajdistrelease = regsubst($operatingsystemrelease, '([^.]*)[.].*', '\1')

  package { 'yum-priorities':
    ensure => present,
    name   => $lsbmajdistrelease ? {
      5 => 'yum-priorities',
      6 => 'yum-plugin-priorities',
    },
  }

  # ensure there are no other repos
  file { 'yum_repos_d':
    ensure  => directory,
    path    => '/etc/yum.repos.d/',
#    source  => 'puppet:///common/empty',
    recurse => true,
    purge   => true,
    force   => true,
    ignore  => '.svn',
    mode    => '0755',
    owner   => root,
    group   => 0;
  }

  #gpg key
  file { 'rpm_gpg':
    path    => '/etc/pki/rpm-gpg/',
    source  => "puppet:///modules/yum/${::operatingsystem}.${lsbmajdistrelease}/rpm-gpg/",
    recurse => true,
#   purge   => true,
    ignore  => '.svn',
    owner   => root,
    group   => 0,
    mode    => '0600',
  }
}
