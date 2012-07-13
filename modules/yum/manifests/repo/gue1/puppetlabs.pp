# /etc/puppet/modules/yum/manifests/repo/gue1/puppetlabs.pp

class yum::repo::gue1::puppetlabs {
	yum::managed_yumrepo { puppetlabs-products:
		descr => 'Puppet Labs Packages $releasever - $basearch',
		baseurl => 'http://10.26.30.97/repo/puppet/$releasever/products/$basearch',
		gpgcheck => 0,
		enabled => 1,
		failovermethod => 'priority',
		gpgkey => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
		priority => 15,
	}
	yum::managed_yumrepo { puppetlabs-deps:
                descr => 'Puppet Labs Dependencies $releasever - $basearch',
		baseurl => 'http://10.26.30.97/repo/puppet/$releasever/dependencies/$basearch',
		gpgcheck => 0,
                enabled => 1,
                failovermethod => 'priority',
                gpgkey => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
                priority => 15,
        }
}
