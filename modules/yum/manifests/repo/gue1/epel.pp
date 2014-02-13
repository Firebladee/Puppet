# /etc/puppet/modules/yum/manifests/repo/gue1/epel.pp

class yum::repo::gue1::epel {
  yum::managed_yumrepo { 'epel':
    descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch',
#   mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
    baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/$basearch',
    enabled        => 1,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 16,
  }
  yum::managed_yumrepo { 'epel-debuginfo':
    descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
#   mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
    baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/$basearch/debug',
    enabled        => 1,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 16,
  }
  yum::managed_yumrepo { 'epel-source':
    descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
#   mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
    baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/SRPMS',
    enabled        => 1,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 16,
  }
  yum::managed_yumrepo { 'epel-testing':
    descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
    mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
    enabled        => 0,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 17,
  }
  yum::managed_yumrepo { 'epel-testing-debuginfo':
    descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
    mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=$basearch',
    enabled        => 0,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 17,
  }
  yum::managed_yumrepo { 'epel-testing-source':
    descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
    mirrorlist     => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=$basearch',
    enabled        => 0,
    gpgcheck       => 1,
    failovermethod => priority,
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority       => 17,
  }
}
