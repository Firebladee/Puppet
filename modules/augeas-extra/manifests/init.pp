# /etc/puppet/modules/augeas-extra/manifests/init.pp

class augeas-extra {

	file { "/usr/share/augeas/lenses/dist/simplelines.aug":
		source  => "puppet:///augeas-extra/simplelines.aug"
	}
}
