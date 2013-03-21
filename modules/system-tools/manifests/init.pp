# Author: Tony Dodd <tony_dodd@londonmarketing.com>

# Class: system-tools
#
# Actions:
#	Maintains installation of various system tools
#
class system-tools {
  package { "wget":
    ensure => latest;
  }
  package { "rsync":
    ensure => latest;
  }
  package { "screen":
    ensure => latest;
  }
  case $operatingsystem {
	"CentOS": {
		package { "bind-utils":
		ensure => latest;
		}
		package { "system-config-firewall-tui":
		ensure => latest;
		}
		package { "vim-enhanced":
		ensure => latest;
		}
	}
  }
}

