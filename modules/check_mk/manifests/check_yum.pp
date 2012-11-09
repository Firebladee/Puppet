# /etc/puppet/modules/check_mk/manifests/check_yum.pp

class check_mk::check_yum {
	case $lsbmajdistrelease {
		'5':	{ package { yum-security:		ensure => latest;}}
		'6':	{ package { yum-plugin-security:	ensure => latest;}}
	}
	file { "/usr/lib/check_mk_agent/local/check_yum":
		mode	=> 711,
		owner	=> root,
		group	=> root,
		ensure	=> present,
		source	=> "puppet:///check_mk/check_yum"
	}
}
