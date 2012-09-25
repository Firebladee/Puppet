# /etc/puppet/modules/puppet/manifests/init.pp

class puppet {

	file { "/etc/puppet/puppet.conf":
                        mode    => 644,
                        owner   => root,
                        group   => root,
                        ensure  => present,
                        source  => "puppet:///puppet/puppet.conf"
                }
}
