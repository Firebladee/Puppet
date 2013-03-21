class accwebpublicweb {

	include php5
	include php5::mysql
	include git
	include pdftk
	
	package { httpd: ensure => installed }
	
	$packagelist = ["php", "httpd"]
	service { "httpd":
		ensure => running,
		enable => true,
		hasrestart => true,
		require => [Package[$packagelist]],
    	}
}
