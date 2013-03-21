class yumrepo {

	package { "lighttpd":
		ensure => installed,
	}

	service { "lighttpd":
		ensure => running,
		require => Package["lighttpd"],
	}

	file { "/etc/lighttpd/":
		ensure => directory,
		recurse => true,
		purge => true,
		force => true,
		owner => "root",
		group => "root",
		mode => 0755,
		source => "puppet:///modules/yumrepo/lighttpd-config",
		require => [User["yum"], Package["lighttpd"], File["/var/www"]],
	}

	

	file { "/etc/lighttpd/lighttpd.conf":
		ensure => file,
		source => "puppet:///modules/yumrepo/lighttpd-config/lighttpd.conf",
		owner => "root",
		group => "root",
		mode => 0644,
		require => [Package["lighttpd"], File["/var/www"], File["/etc/lighttpd"]],
		notify => Service["lighttpd"],
	}

	file { "/var/log/lighttpd":
		ensure => directory,
		force => true,	
		owner => "yum",
		group => "yum",
		mode => 0750,
		require => File["/etc/lighttpd/lighttpd.conf"],
	}

	file { "/var/log/lighttpd/access.log":
		ensure => file,
		owner => "yum",
		group => "yum",
		mode => 0644,
		require => File["/var/log/lighttpd"],
	}

	file { "/var/log/lighttpd/error.log":
		ensure => file,
		owner => "yum",
		group => "yum",
		mode => 0644,
		require => File["/var/log/lighttpd"],
	}

#    package { sudo: ensure => latest }

	group { "yum":
		ensure => "present",
	}

	user { "yum": 
		gid => 'yum',
		comment => 'This user was created by Puppet', 
		ensure => 'present', 
	#	managed_home => 'true',
		require => Group["yum"],
	} 

	file { "/var/www/yum":
		ensure => directory,
		recurse => true,
		purge => true,
		force => true,
		owner => "yum",
		group => "yum",
		mode => 0644,
		source => "puppet:///files/yum",
		require => [User["yum"], Package["lighttpd"], File["/var/www"]],
	}

	file { "/var/www/":
		ensure => directory,
		recurse => true,
		purge => true,
		force => true,
		owner => "root",
		group => "root",
		mode => 0644,
	}

}
