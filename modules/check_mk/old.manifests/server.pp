# /etc/puppet/modules/check_mk/manifests/init.pp

# check_mk::server still under construction - do not use
# Almost there, does not auto add new clients.
# New update to allow working under omd

class check_mk::server {

#	require check_mk::params
#	require check_mk::dir

	$check_mk_location = "$omd_site_home/etc/check_mk"

	define check_mk_server {
#		notify { "omd site = $name": }
		$omd_site_home  = "/opt/omd/sites/${name}"
#		notify { "omd site home = $omd_site_home": }
	        $check_mk_location = "$omd_site_home/etc/check_mk"
        	$check_mk_agent_location = "$check_mk_location/agents"

#		$check_mk_server_flag = "/var/lock/check_mk_server"
#		$check_mk_server_version = "check_mk-1.1.12p3"

		File<<| tag == 'check_mk_remote' |>>

		exec { "check_mk_update_$name":
			command => "/bin/su - $name -c 'check_mk -I; check_mk -O'",
#			refreshonly => true,
		}

		file { "/conf.d/main_$name":
        	        path    => "$check_mk_location/conf.d/main",
                	ensure  => directory,
	                purge   => true,
        	        recurse => true,
                	notify  => Exec["check_mk_update_$name"],
	        }

		# check_mk parents

		File <<| tag == 'check_mk_remote_parents' |>>

		exec { "check_mk_parents_$name":
			command	=> "$omd_site_home/bin/check_mk -O",
			refreshonly => true,
		}

		file { "$check_mk_location/conf.d/parents":
			path	=> "$check_mk_location/conf.d/parents",
			ensure	=> directory,
			purge	=> true,
			recurse	=> true,
			notify	=> Exec["check_mk_parents_$name"],
		}

		file { "$check_mk_location$/main.mk":
			path    => "$check_mk_location/main.mk",
			mode    => 644,
			owner   => "${name}",
			group   => "${name}",
			ensure  => present,
			source  => "puppet:///check_mk/main.mk"
		}
	}

	check_mk_server { $omd_site: }

#	file { "$check_mk_location$/main.mk":
#		path    => "$check_mk_location",
#		mode    => 644,
#		owner   => "${name}",
#		group   => "${name}",
#		ensure  => present,
#		source  => "puppet:///check_mk/main.mk"
#	}
}
