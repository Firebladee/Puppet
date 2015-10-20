# /etc/puppet/manifests/site.pp

#import "modules"
#import "nodes"

filebucket { main: server => "puppet.example.com" }

# global defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

Package {
	provider => $operatingsystem ? {
		redhat => yum,
		centos => yum,
		fedora => yum
	}

hiera_include('classes')

node default {}
}
