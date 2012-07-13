# /etc/puppet/modules/yum/manifests/repo/puppetlabs.pp

class yum::repo::spacewalk-client {
	yum::managed_yumrepo { spacewalk-client:
		descr => 'Spacewalk Client',
		baseurl => 'http://192.168.34.240/repos/inhouse/spacewalkclient-0.7-$basearch/',
		gpgcheck => 1,
		enabled => 0,
		failovermethod => 'priority',
		gpgkey => 'http://192.168.34.240/repos/keys/RPM-GPG-KEY-spacewalk',
		priority => 15,
	}
}
