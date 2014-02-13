# /etc/puppet/modules/yum/manifests/repo/amazon.pp

class yum::repo::amazon {
	yum::managed_yumrepo {base:
		descr    => 'amzn-main-Base',
		baseurl  => 'http://repo.eu-west-1.amazonaws.com/$releasever/main/mirror.list',
		enabled  => 1,
		gpgcheck => 0,
		gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
		priority => 10,
	}

	yum::managed_yumrepo {updates:
		descr    => 'amzn-updates-Base',
		baseurl  => 'http://repo.eu-west-1.amazonaws.com/$releasever/updates/mirror.list',
		enabled  => 1,
		gpgcheck => 0,
		gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
		priority => 10,
	}
}
