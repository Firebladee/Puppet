# /etc/puppet/modules/check_mk/manifests/parents.pp

class check_mk::parents {

#	require check_mk::params

	define check_mk_parents {
		$omd_site_home  = "/opt/omd/sites/$name"
        	$check_mk_location = "$omd_site_home/etc/check_mk"
	        $check_mk_agent_location = "$check_mk_location/agents"

		@@file {
			"$check_mk_location/conf.d/parents/${hostname}.mk":
#			ensure => file, content => "parents += [ ("${parent}", [ "${hostname}"])]",
			content => template("check_mk/parents.erb"),
			tag => 'check_mk_remote_parents'
		}
	}

	check_mk_parents { $omd_site: }
}
