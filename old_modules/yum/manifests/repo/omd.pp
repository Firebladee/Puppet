# /etc/puppet/modules/yum/manifests/repo/omd.pp

# Set up for centos 6 only

class yum::repo::omd {
  yum::managed_yumrepo { 'omd-products':
    descr          => 'OMD Packages $releasever - $basearch',
    baseurl        => 'http://labs.consol.de/OMD/rh60/stable/$basearch',
    enabled        => 1,
    gpgcheck       => 0,
    failovermethod => 'priority',
    gpgkey         => 'http://labs.consol.de/OMD/RPM-GPG-KEY',
    priority       => 20,
  }
}
