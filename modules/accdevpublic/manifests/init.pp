class accdevpublic {

	file { "/var/www/html/AccDevPublic":
		ensure => directory,
		recurse => true,
		purge => true,
		force => true,
		owner => "apache",
		group => "apache",
		source => "puppet:///accdevpublic/AccDevPublic",
	}
	
	file { "/var/www/html/AccDevPublic/.git":
		ensure => absent,
		recurse => true,
		purge => true,
		force => true,
	}

}
