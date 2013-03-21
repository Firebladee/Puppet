class named {

	package { "bind":
		ensure => latest,
	}

	service { "named":
		ensure => running,
		require => [Package["bind"], File["/etc/named.conf"]],
		hasstatus => true,
		enable => true,
		restart => '/sbin/service named reload',
	}

	file { "/etc/named/":
		ensure => directory,
		recurse => true,
		purge => true,
		force => true,
		owner => "root",
		group => "named",
		mode => 0755,
		source => "puppet:///modules/named/named",
		require => [Package["bind"], File["/etc/named.conf"]],
		notify	=> Service["named"],
	}

	

	file { "/etc/named.conf":
		ensure => file,
		source => "puppet:///modules/named/named.conf",
		owner => "root",
		group => "named",
		mode => 0640,
		require => Package["bind"],
		notify => Service["named"],
	}

	file { "/etc/rndc.conf":
		ensure => file,
		source => "puppet:///modules/named/rndc.conf",
		owner => "root",
		group => "root",
		mode => 0640,
		require => Package["bind"],
		notify => Service["named"],
	}

#    package { sudo: ensure => latest }
}
