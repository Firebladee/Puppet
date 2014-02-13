# /etc/puppet/modules/yum/manifests/repo/epel.pp

class yum::repo::epel {
	yum::managed_yumrepo { epel:
		descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
#		baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/$basearch',
		enabled        => 1,
		gpgcheck       => 1,
		failovermethod => 'priority',
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
		priority       => 16,
	}
	yum::managed_yumrepo { epel-debuginfo:
		descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch',
#		baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/$basearch/debug',
		enabled        => 1,
		gpgcheck       => 1,
		failovermethod => 'priority',
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
		priority       => 16,
	}
	yum::managed_yumrepo { epel-source:
		descr          => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch',
#		baseurl        => 'http://download.fedoraproject.org/pub/epel/$releasever/SRPMS',
		enabled        => 1,
		gpgcheck       => 1,
		failovermethod => 'priority',
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
		priority       => 16,
	}
	yum::managed_yumrepo { epel-testing:
		descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-epel6&arch=$basearch',
		enabled        => 0,
		gpgcheck       => 1,
		failovermethod => 'priority',
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
		priority       => 17,
	}
	yum::managed_yumrepo { epel-testing-debuginfo:
		descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-debug-epel6&arch=$basearch',
		enabled        => 0,
		gpgcheck       => 1,
		failovermethod => 'priority',
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
		priority       => 17,
	}
	yum::managed_yumrepo { epel-testing-source:
		descr          => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
		mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=testing-source-epel6&arch=$basearch',
		enabled        => 0,
		gpgcheck       => 1,
		failovermethod => priority,
		gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever',
	priority         => 17,
	}
}
