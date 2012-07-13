# /etc/puppet/modules/sqlplus/manifests/init.pp

class sqlplus {

	file { "/tmp/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.i386.rpm":
		source	=> "puppet:///sqlplus/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.i386.rpm"
	}

	file { "/tmp/oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm":
		source	=> "puppet:///sqlplus/oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm"
	}

	package { "oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.i386.rpm":
		ensure => installed,
		source => "/tmp/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.i386.rpm",
		require => [File["/tmp/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.i386.rpm"], Package["oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm"]]
	}

	package { "oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm":
		ensure => installed,
		source => "/tmp/oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm",
		require => File["/tmp/oracle-instantclient11.2-basic-11.2.0.3.0-1.i386.rpm"]
	}
}		
		
