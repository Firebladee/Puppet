# /etc/puppet/modules/icinga/manifests/icinga_web.pp

class icinga::web {
	package { icinga-gui:	ensure => installed;
	}

}
