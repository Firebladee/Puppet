# Author: Kumina bv <support@kumina.nl>

# Class: sysctl
#
# Actions:
#	Undocumented
#
# Depends:
#	Undocumented
#	gen_puppet
#
class sysctl {
  exec { "reload-sysctl":
    command     => "/sbin/sysctl -p /etc/sysctl.conf",
    subscribe   => File["/etc/sysctl.conf"],
    refreshonly => true;
  }

  file { "/etc/sysctl.conf":
    checksum => "md5",
  }
}
