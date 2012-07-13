# /etc/puppet/modules/yum/manifests/cron.pp
#
# yum::cron
#
#
class yum::cron {
	package { yum-cron:
		ensure => present
	}

	service { yum-cron:
		enable => true,
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		require => Package[yum-cron],
	}
}
