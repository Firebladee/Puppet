# /etc/puppet/modules/check_mk/manifests/package/puppet/agent.pp

# usage
# for agant
# include check_mk::package::puppet::agent

class check_mk::package::puppet::agent {

	case $architecture {
		i386: {
			file { "/usr/lib/check_mk_agent/plugins/puppet":
			ensure	=> present,
			mode	=> 744,
			source	=> "puppet:///check_mk/package/plugins/puppet"
			}
			file { "/usr/local/bin/puppetstatus":
			ensure	=> present,
			mode	=> 744,
			source	=> "puppet:///check_mk/package/bin/puppetstatus.py"
			}
			# Need to add check for correct python path
			file { "/usr/lib/python2.6/puppetstatus.py":
			ensure	=> present,
			source	=> "puppet:///check_mk/package/lib/puppetstatus.py"
			}
		}
		x86_64: {
			file { [ "/usr/lib64/check_mk_agent", "/usr/lib64/check_mk_agent/plugins" ]:
			ensure  => directory
			}
			file { "/usr/lib64/check_mk_agent/plugins/puppet":
			ensure  => present,
			mode    => 744,
			source  => "puppet:///check_mk/package/plugins/puppet"
			}
                        file { "/usr/local/bin/puppetstatus":
                        ensure  => present,
                        mode    => 744,
                        source  => "puppet:///check_mk/package/bin/puppetstatus.py"
                        }
			case $pythonmmversion {
				2.4 : {
					file { "/usr/lib64/python2.4/puppetstatus.py":
                                        ensure  => present,
                                        source  => "puppet:///check_mk/package/lib/puppetstatus.py"
                                        }
				}
				2.6 : {
		                        case $hostname {
						gucedapp02 : {
							file { "/usr/lib/python2.6/puppetstatus.py":
	                                        	ensure  => present,
        	                                	source  => "puppet:///check_mk/package/lib/puppetstatus.py"
							}
						}
						gucedapp01, gucedapp06, gucedapp07, gucedapp08 : {
							file { "/usr/lib/python2.4/puppetstatus.py":
							ensure  => present,
							source  => "puppet:///check_mk/package/lib/puppetstatus.py"
							}
						}
						default : {
							file { "/usr/lib64/python2.6/puppetstatus.py":
							ensure  => present,
		        	                	source  => "puppet:///check_mk/package/lib/puppetstatus.py"
                			        	}
						}
					}
				}
			}
		}
		default : {}

	}
}
