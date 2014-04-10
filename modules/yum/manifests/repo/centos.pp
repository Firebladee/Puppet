# /etc/puppet/modules/yum/manifests/repo/gue1/centos.pp

class yum::repo::centos {
  yum::managed_yumrepo {'base':
    descr    => 'CentOS-$releasever - Base',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
    enabled  => 1,
    gpgcheck => 0,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }

  yum::managed_yumrepo {'updates':
    descr    => 'CentOS-$releasever - Updates',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
    enabled  => 1,
    gpgcheck => 0,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }

  yum::managed_yumrepo {'extras':
    descr    => 'CentOS-$releasever - Extras',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
    enabled  => 1,
    gpgcheck => 0,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }
}
