# /etc/puppet/modules/check_mk/manifests/allow.pp

# Usage
# include hosts::allow

class hosts::allow {
#	case $hostname {
#		gucedapp01, gucedapp06, gucedapp08 : {
#			file { "/etc/hosts.allow":
#			ensure	=> present,
#			source	=> "puppet:///hosts/hosts.allow"
#			}
#		}
#		gucedora06, gucedora09, gucedora12, gucedapp07, gucedora05, gucedora08, gucerapp01, gucerapp02, gucerapp03, gucedora15 : {
#			file { "/etc/hosts.allow":
#			ensure	=> present,
#			content	=> template("hosts/hosts.allow.erb"),
#			}
#		}
#		puppet-test : {
#			package { augeas:	ensure => latest}
#		}
#		default : { fail ("no hosts.allow file yet for this server") }
#	}

#	define hostsallow ( $sshd = [], $check_mk_agent = [], $snmpd = [], $nrpe = [] ) {
#		augeas { "hosts.allow":
#			context	=> "/files/etc/hosts.allow",
#			changes	=> template("hosts/hosts.allow.erb")
#		}
#	}

	file { "/etc/hosts.allow":
		ensure  => present,
		content => template("hosts/hosts.allow.erb"),
	}
}
