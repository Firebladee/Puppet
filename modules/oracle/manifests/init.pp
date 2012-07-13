#/etc/puppet/modules/oracle/manifests/init.pp

# This will prepare the server for oracle install.
# NOTE: will need a reboot after this has run

# Use
# include oracle

class oracle {

#	import "common/line.pp"

	$test			= "X Window System"
	$oracle_soft_nproc	= 2047
	$oracle_hard_nproc	= 16384
	$oracle_soft_nofile	= 1024
	$oracle_hard_nofile	= 65536
	$oracle_file_max	= 6553600
	$oracle_kernel_shmmax	= 2147483648
	$oracle_kernel_shmall	= 2097152
	$oracle_kernel_shmmni	= 4096
	$oracle_kernel_sem	= "250 32000 100 128"
	$oracle_range		= "1024 65000"
	$oracle_rmem_default	= 4194304
	$oracle_rmem_max	= 4194304
	$oracle_wmem_default	= 262144
	$oracle_wmem_max	= 262144

	case $lsbmajdistrelease {
		'5':	{
			package {
				yum-downloadonly:		ensure => latest;
				"libXp.i386":			ensure => installed;
				"libXt.i386":			ensure => installed;
				"compat-libstdc++-33.i386":	ensure => installed;
				"glibc-devel.i386":		ensure => installed;
				"libaio.i386":			ensure => installed;
				"libstdc++.i386":		ensure => installed;
				"compat-libstdc++-296.i386":	ensure => installed;
				"compat-db.i386":		ensure => installed;
				}
			}
		'6': {
			package {
				yum-plugin-downloadonly:	ensure => latest;
				"libXp.i686":			ensure => installed;
				"libXt.i686":			ensure => installed;
				"compat-libstdc++-33.i686":	ensure => installed;
				"glibc-devel.i686":		ensure => installed;
				"libaio.i686":			ensure => installed;
				"libstdc++.i686":		ensure => installed;
				"compat-libstdc++-296.i686":	ensure => installed;
				"compat-db.i686":		ensure => installed;
			}
		}
	}

	package { 
		libXp:				ensure => installed;
		libXaw:				ensure => installed;
		libXpm:				ensure => installed;
		"compat-libstdc++-33.x86_64":	ensure => installed;
		elfutils-libelf-devel:		ensure => installed;
		gcc:				ensure => installed;
		"gcc-c++.x86_64":		ensure => installed;
		"glibc-devel.x86_64":		ensure => installed;
		libaio:				ensure => installed;
		libaio-devel:			ensure => installed;
		openmotif:			ensure => installed;
		openmotif22:			ensure => installed;
		"compat-db.x86_64":		ensure => installed;
		"compat-gcc-34.x86_64":		ensure => installed;
		"compat-gcc-34-c++.x86_64":	ensure => installed;
		sysstat:			ensure => installed;
		unixODBC:			ensure => installed;
		"unixODBC-devel":		ensure => installed;
	}

	exec { "oracle xwindows":
		command	=> "yum -y groupinstall '$test'",
		unless	=> "yum -y groupinstall '$test' --downloadonly",
		timeout	=> 600
	}

	group { "oinstall":
		ensure	=> present
	}

	users::add { oracle: 
		uid	=> '600',
		gid	=> 'oracle',
		shell	=> "/bin/bash",
		home	=> "/home/oracle",
		password => '$1$ps8uBy4G$qaZ67.K25d.MAoI13xB9z/',
		groups	=> "oinstall"
	}

	file { "/etc/security/limits.conf":
		ensure	=> present,
		content	=> template("oracle/limits.conf.erb")
	}

#	line { pam_login:
#		file	=> "/etc/pam.d/login",
#		line	=> "session required /lib64/security/pam_limits.so"
#	}

	file { "/etc/sysctl.conf":
		ensure	=> present,
		content	=> template("oracle/sysctl.conf.erb")
	}
}
