# /etc/puppet/modules/yum/manifests/repo/redhat.pp

class yum::repo::redhat {
  yum::managed_yumrepo {'base':
    descr    => 'RedHat-$releasever - Base - PUPPET Controlled',
    baseurl  => 'http://wkse13p2xrep01.wok1.egalacoral.com/repo/RedHat/$releasever/os/$basearch/Server',
    enabled  => 1,
    gpgcheck => 1,
#   gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    gpgkey   => 'http://10.26.30.97/repo/RedHat/5Server/$releasever/os/$basearch/RPM-GPG-KEY-redhat-release',
    priority => 1,
  }

  yum::managed_yumrepo {'extras':
    descr    => 'CentOS-$releasever - Extras - PUPPET Contorled',
    baseurl  => 'http://wkse13p2xrep01.wok1.egalacoral.com/repo/CentOS/$releasever/extras/$basearch/',
    enabled  => 1,
    gpgcheck => 0,
#   gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    priority => 1,
  }
}
