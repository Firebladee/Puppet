# /etc/puppet/modules/icinga/manifests/init.pp

$icinga_sql_path = "/root/icinga_dbimport.sql"
$icinga_sql_flag = "/var/lock/icinga_dbimport"

class icinga {
	package { icinga:		ensure => installed;
		  icinga-idoutils:	ensure => installed;
		  icinga-gui:		ensure => installed;
		  icinga-doc:		ensure => installed;
		  icinga-api:		ensure => installed;
#		  mysql-server:		ensure => installed;
		  libdbi:		ensure => installed;
		  libdbi-devel:		ensure => installed;
		  libdbi-drivers:	ensure => installed;
		  libdbi-dbd-mysql:	ensure => installed;
#		  nagios-nrpe:		ensure => installed;
#		  nagios-plugins-nrpe:	ensure => installed;
		  gd:			ensure => installed;
		  glibc:		ensure => installed;
		  glibc-common:		ensure => installed;
		  php-soap:		ensure => installed;
		  php-xml:		ensure => installed;
		  php-xmlrpc:		ensure => installed;
		  php-ldap:		ensure => installed;
		  php-gd:		ensure => installed;
		  php-mysql:		ensure => installed;
	}
	service { icinga:
		ensure		=> running,
		enable		=> true,
		hasstatus	=> true,
		require		=> [Package["icinga"], Service["ido2db"]];
	}
	service { ido2db:
		ensure		=> running,
		enable		=> true,
		hasstatus	=> true,
		require		=> [Package["icinga-idoutils"], Service["mysqld"]];
	}
#	service { mysqld:
#		ensure		=> running,
#		enable		=> true,
#		hasstatus	=> true,
#		require		=> Package["mysql-server"];
#	}
	service { httpd:
		ensure		=> running,
		enable		=> true,
		hasstatus	=> true;
	}
	exec { "icinga_sql":
		command => "mysql icinga < $icinga_sql_path; /bin/touch $icinga_sql_flag",
		onlyif => "test ! -f $icinga_sql_flag",
		require => [Package["mysql-server"], File["$icinga_sql_path"]],
	}
	
	file { "$icinga_sql_path":
		mode => 600, owner => root, group => root,
		ensure => present,
		path => "$icinga_sql_path",
		source => "puppet:///icinga/icinga.sql",
	}
	notice ("Delete $icinga_sql_flag to re import the icinga database")

	file { "/etc/icinga/resource.cfg":
		mode => 0660, owner => icinga, group => icinga,
		source => "puppet:///icinga/resource.cfg",
		notify => Service["icinga"],
		require => Package["icinga"],
	}
	file { "/usr/local/icinga-web/app/config/databases.xml":
		mode => 0644, owner => root, group => bin,
		source => "puppet:///icinga/databases.xml",
		# To-do - add require or check of some kind
	}
}
