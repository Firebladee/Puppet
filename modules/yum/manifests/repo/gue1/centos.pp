# /etc/puppet/modules/yum/manifests/repo/gue1/centos.pp

class yum::repo::gue1::centos {
  yum::managed_yumrepo {'base':
    descr    => 'CentOS-$releasever - Base',
    baseurl  => 'http://10.26.30.97/repo/CentOS/$releasever/os/$basearch/',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }

  yum::managed_yumrepo {'updates':
    descr    => 'CentOS-$releasever - Updates',
    baseurl  => 'http://10.26.30.97/repo/CentOS/$releasever/updates/$basearch/',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }

  yum::managed_yumrepo {'extras':
    descr    => 'CentOS-$releasever - Extras',
    baseurl  => 'http://10.26.30.97/repo/CentOS/$releasever/extras/',
    enabled  => 1,
    gpgcheck => 0,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 1,
  }
}
