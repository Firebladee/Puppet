# /etc/puppet/yum/manifests/repo/gue1/foreman.pp

class yum::repo::gue1::foreman {
  yum::managed_yumrepo { 'foreman':
    descr          => 'Foreman Repo',
    baseurl        => 'http://yum.theforeman.org/stable/',
    enabled        => 1,
    gpgcheck       => 0,
    failovermethod => 'priority',
#   gpgkey         => 'http://yum.theforeman.org/RPM-GPG-KEY-foreman',
    priority       => 16,
  }
}
