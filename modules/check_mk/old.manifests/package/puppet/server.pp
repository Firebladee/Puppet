# /etc/puppet/modules/check_mk/manifests/package/puppet/server.pp

# usage
# $omd_site = "DEV5"
# include check_mk::package::puppet::server

class check_mk::package::puppet::server {

	define check_mk_package_puppet_server {
		$check_mk_puppet_check  = "/opt/omd/sites/$name/share/check_mk/checks"
		file { "check_mk_puppet_$name":
			path	=> "$check_mk_puppet_check/puppet",
			ensure	=> present,
			source	=> "puppet:///check_mk/package/checks/puppet"
		}
	}
	check_mk_package_puppet_server { $omd_site: }
}
