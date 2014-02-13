# /etc/puppet/modules/yum/manifests/repo/gue1/tmz.pp

class yum::repo::gue1::tmz {
  yum::managed_yumrepo { 'tmz-puppet':
    descr          => 'Puppet for EL $releasever - $basearch',
    baseurl        => 'http://tmz.fedorapeople.org/repo/puppet/epel/$releasever/$basearch',
    enabled        => 1,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'http://tmz.fedorapeople.org/repo/RPM-GPG-KEY-tmz',
    priority       => 16,
  }
  yum::managed_yumrepo { 'tmz-puppet-source':
    descr          => 'Puppet for EL $releasever - Source',
    baseurl        => 'http://tmz.fedorapeople.org/repo/puppet/epel/$releasever/SRPMS',
    enabled        => 0,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'http://tmz.fedorapeople.org/repo/RPM-GPG-KEY-tmz',
    priority       => 16,
  }
}
