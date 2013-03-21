class php5::mysql {
	
	package { php-mysql:
		ensure => installed,
		require => Package["php"],
	}
}
