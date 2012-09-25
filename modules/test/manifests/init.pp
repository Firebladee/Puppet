# /etc/puppet/modules/test/manifests/init.pp

class test (
	$omd_site	= $test::params::omd_site,
	$install	= $test::params::install,
	$parents	= $test::params::parents,
	$check_mk_tags	= $test::params::check_mk_tags,
	$check_mk_alias	= $test::params::check_mk_alias,
	) inherits test::params {

	if $test::install == 'agent' or $test::install == 'server' {
#		include test::agent_test

        	include xinetd

	        $check_mk_agent = "check_mk-agent-1.1.12p3-1.noarch.rpm"
        	$omd_site_home  = "/opt/omd/sites/$omd_site"
	        $check_mk_location = "$omd_site_home/etc/check_mk"
	        $check_mk_agent_location = "$check_mk_location/agents"

	       	package { nagios-plugins-setuid:        ensure => latest;
	        }

	       	file { "/etc/xinetd.d/check_mk":
	                mode    => 644,
        	        owner   => root,
                	group   => root,
	                require => Exec["rpm -i /tmp/$check_mk_agent"],
        	        ensure  => present,
                	source  => "puppet:///check_mk/check_mk"
	        }

	       	file { "/usr/lib/nagios/plugins/check_icmp":
        	       	mode    => 4755,
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

        	check_mk_agent1 { $omd_site: }
	}

	if $test::install == 'server' {
		check_mk_server1 { $omd_site: }
	}

	if $test::parents {
		check_mk_parents1 { $omd_site: }
	}
}

define check_mk_agent1 (
#	$check_mk_tags = ''
) {

        $omd_site_home  = "/opt/omd/sites/$name"
        $check_mk_location = "$omd_site_home/etc/check_mk"
        $check_mk_agent_location = "$check_mk_location/agents"

	@@file {
		"$check_mk_location/conf.d/main/${hostname}.mk":
		ensure => file,
		content => template("test/main.erb"),
		tag => 'check_mk_remote'
	}

	file { "/tmp/$omd_site":
		path => "/tmp/${omd_site}",
		content => template("test/main.erb"),
	}

	augeas { "check_mk_cron.allow" :
		context => "/files/etc/cron.allow",
#		changes => "set line[last()+1] $name",
		changes	=> "set 1[last()+1] $name",
#		onlyif  => "match /files/etc/cron.allow/* include ALL",
		onlyif	=> "match *[.='$name'] not_include $name",
#		onlyif	=> "get 1[.='ALL'] == ALL",
        }
}

define check_mk_server1 {
#	notify { "omd site = $name": }
	$omd_site_home  = "/opt/omd/sites/${name}"
#       notify { "omd site home = $omd_site_home": }
        $check_mk_location = "$omd_site_home/etc/check_mk"
        $check_mk_agent_location = "$check_mk_location/agents"

#       $check_mk_server_flag = "/var/lock/check_mk_server"
#       $check_mk_server_version = "check_mk-1.1.12p3"

        File<<| tag == 'check_mk_remote' |>>

        exec { "check_mk_update_$name":
        	command => "/bin/su - $name -c 'check_mk -I; check_mk -O'",
#               refreshonly => true,
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
        	command => "$omd_site_home/bin/check_mk -O",
                refreshonly => true,
        }

        file { "$check_mk_location/conf.d/parents":
        	path    => "$check_mk_location/conf.d/parents",
                ensure  => directory,
                purge   => true,
                recurse => true,
                notify  => Exec["check_mk_parents_$name"],
        }
	file { "$check_mk_location$/main.mk":
        	path    => "$check_mk_location/main.mk",
                mode    => 644,
                owner   => "${name}",
                group   => "${name}",
                ensure  => present,
                source  => "puppet:///check_mk/main.mk"
        }

	# Add site to cron.allow
	augeas { "check_mk_cron.allow" :
		context	=> "/files/etc/cron.allow",
		changes	=> "set line[last()+1] $name",
		onlyif	=> "match /* $name != $name",
	}

        # Add site to access.conf

}

define check_mk_parents1 {
	$omd_site_home  = "/opt/omd/sites/$name"
        $check_mk_location = "$omd_site_home/etc/check_mk"
        $check_mk_agent_location = "$check_mk_location/agents"

        @@file {
        	"$check_mk_location/conf.d/parents/${hostname}.mk":
#               ensure => file, content => "parents += [ ("${parent}", [ "${hostname}"])]",
                content => template("test/parents.erb"),
                tag => 'check_mk_remote_parents'
        }
}
