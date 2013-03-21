class php5 {


	$packagelist = ["php", "php-common"]
	package {
		$packagelist: ensure=>installed,
		require => Package["httpd"],
	}
}
