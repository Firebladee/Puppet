# /etc/puppet/modules/yum/manifests/repo/amazon.pp

class yum::repo::amazon {
  yum::managed_yumrepo {'base':
    descr          => 'amzn-main-Base',
    mirrorlist     => 'http://repo.eu-west-1.amazonaws.com/$releasever/main/mirror.list',
    enabled        => 1,
    gpgcheck       => 1,
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
    priority       => 10,
    failovermethod => 'priority',
  }

  yum::managed_yumrepo {'updates':
    descr      => 'amzn-updates-Base',
    mirrotlist => 'http://repo.eu-west-1.amazonaws.com/$releasever/updates/mirror.list',
    enabled        => 1,
    gpgcheck       => 1,
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
    priority       => 10,
    failovermethod => 'priority',
  }
}
