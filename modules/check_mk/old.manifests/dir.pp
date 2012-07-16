# /etc/puppet/modules/check_mk/manifests/dir.pp

class check_mk::dir {

#	file { "/etc/check_mk/auto":
#                ensure => directory
#        }

#	file { "/etc/check_mk/agents":
#                ensure => directory,
#                notify => Exec["/etc/check_mk/auto/read.sh"],
#        }

#	file { "/etc/check_mk/agents/main":
#		ensure	=> directory
#	}

#	file { "/etc/check_mk/agents/parents":
#		ensure	=> directory
#	}

	# create directory for each agent.  May be with a script that reads /etc/check_mk/agents/main, then create the corisbonding dir. in /etc/check_mk/agents/parents"

}
