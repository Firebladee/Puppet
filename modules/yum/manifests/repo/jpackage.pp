# /etc/puppet/modules/yum/manifests/repo/jpackage.pp

class yum::repo::jpackage {
  yum::managed_yumrepo { 'jpackage-generic':
    descr          => 'JPackage (free), generic',
    mirrorlist     => 'http://www.jpackage.org/jpackage_generic_1.7.txt',
    failovermethod => 'priority',
    gpgcheck       => 1,
    gpgkey         => 'http://www.jpackage.org/jpackage.asc',
    enabled        => 1,
    priority       => 1,
  }
  yum::managed_yumrepo { 'jpackage-rhel':
    descr          => 'JPackage (free) for Red Hat Enterprise Linux $releasever',
    mirrorlist     => "http://www.jpackage.org/jpackage_rhel-${::lsbmajdistrelease}_1.7.txt",
    failovermethod => 'priority',
    gpgcheck       => 1,
    gpgkey         => 'http://www.jpackage.org/jpackage.asc',
    enabled        => 1,
    priority       => 1,
  }
  yum::managed_yumrepo { 'jpackage-generic-nonfree':
    descr          => 'JPackage (non-free), generic',
    mirrorlist     => 'http://www.jpackage.org/jpackage_generic_nonfree_1.7.txt',
    failovermethod => 'priority',
    gpgcheck       => 1,
    gpgkey         => 'http://www.jpackage.org/jpackage.asc',
    enabled        => 1,
    priority       => 1,
  }
}
