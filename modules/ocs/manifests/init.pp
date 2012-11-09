# /etc/puppet/modules/ocs/manifests/init.pp

class ocs {
	case $operatingsystem {
		centos: {
			package { "ocsinventory-agent": ensure => latest;
				  "lsb_release.noarch": ensure => latest }
			}
		redhat: {
			package { "ocsinventory-agent": ensure => latest }
			}
	}
}
