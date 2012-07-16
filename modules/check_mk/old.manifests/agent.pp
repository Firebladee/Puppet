# /etc/puppet/modules/check_mk/manifests/agent.pp

# New update to allow working under omd

class check_mk::agent {

#	requirie check_mk::params

	include xinetd

	$check_mk_agent = "check_mk-agent-1.1.12p3-1.noarch.rpm"
	$omd_site_home  = "/opt/omd/sites/$omd_site"
        $check_mk_location = "$omd_site_home/etc/check_mk"
        $check_mk_agent_location = "$check_mk_location/agents"

	package { nagios-plugins-setuid:	ensure => latest;
	}

	file { "/etc/xinetd.d/check_mk":
		mode	=> 644,
		owner	=> root,
		group	=> root,
		require	=> Exec["rpm -i /tmp/$check_mk_agent"],
		ensure	=> present,
		source	=> "puppet:///check_mk/check_mk"
	}

	file { "/usr/lib/nagios/plugins/check_icmp":
		mode	=> 4755,
		require => Package["nagios-plugins-setuid"],
	}

	file { "/tmp/$check_mk_agent":
		ensure => present,
		path => "/tmp/$check_mk_agent",
		source => "puppet:///check_mk/$check_mk_agent"
	}

	exec { "rpm -i /tmp/$check_mk_agent":
		cwd => "/tmp",
		creates => "/usr/bin/check_mk_agent",
		require => Package["xinetd"]
	}

#	define check_mk_agent (
#		$check_mk_tags = '' ) {
#
#		$omd_site_home  = "/opt/omd/sites/$name"
#		$check_mk_location = "$omd_site_home/etc/check_mk"
#		$check_mk_agent_location = "$check_mk_location/agents"
#
#		@@file {
#			"$check_mk_location/conf.d/main/${hostname}.mk":
#			ensure => file,
#			content => template("check_mk/test.erb"),
#			tag => 'check_mk_remote'
#		}
#	}

	check_mk_agent { $omd_site: }

}

define check_mk_agent (
	$check_mk_tags = '' ) {

	$omd_site_home  = "/opt/omd/sites/$name"
	$check_mk_location = "$omd_site_home/etc/check_mk"
	$check_mk_agent_location = "$check_mk_location/agents"

	@@file {
		"$check_mk_location/conf.d/main/${hostname}.mk":
		ensure => file,
		content => template("check_mk/main.erb"),
		tag => 'check_mk_remote'
	}
}

