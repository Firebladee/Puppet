# /etc/puppet/manifests/site.pp

hiera_include('classes')

#import "modules"
#import "nodes"

filebucket { main: server => "puppet.example.com" }

# global defaults
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

#Package {
#	provider => $operatingsystem ? {
#		redhat => yum,
#		centos => yum,
#		fedora => yum
#	}
#}

#node 'default' {
#  hiera_include('classes')

#  include vagrant

  Yumrepo <| |> -> Package #<| provider != 'rpm' |>

#  class {'yum':
#    extrarepo => ['omd','epel','puppetlabs','remi',]
#  }
#}

#node /^puppet\.example\.com$/ { #inherits default {
#  class {'check_mk':
#    install  => 'agent',
#    omd_site => 'test',
#  }
#}

#node /^client1\.example\.com$/ { #inherits default {
#  class { 'omd::install':}
#  $omd_site = 'test'
#  include omd::site::add

#  class {'check_mk':
#    install  => 'server',
#    omd_site => 'test',
#  }

#}

#node /^client2\.example\.com$/ { #inherits default {
#  class {'check_mk':
#    install  => 'agent',
#    omd_site => 'test',
#    check_mk_tags => 'tag_test',
#  }

#  class {'moodle': }

#}
