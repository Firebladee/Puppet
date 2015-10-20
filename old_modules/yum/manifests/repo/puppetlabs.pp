# /etc/puppet/modules/yum/manifests/repo/puppetlabs.pp

class yum::repo::puppetlabs {
  yum::managed_yumrepo { 'puppetlabs-products':
    descr          => 'Puppet Labs Packages $releasever - $basearch',
    baseurl        => 'http://yum.puppetlabs.com/el/6/products/$basearch',
    gpgcheck       => 1,
    enabled        => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    priority       => 15,
  }
  yum::managed_yumrepo { 'puppetlabs-deps':
    descr          => 'Puppet Labs Dependencies $releasever - $basearch',
    baseurl        => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
    gpgcheck       => 1,
    enabled        => 1,
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    priority       => 15,
  }
}
