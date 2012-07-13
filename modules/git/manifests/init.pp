# /etc/puppet/modules/git/manifests/init.pp

class git {

	include xinetd
	include apache

	package {
		git:		ensure	=> installed;
		git-daemon:	ensure	=> installed;
		gitweb:		ensure	=> installed;
	}

	file { "/etc/xinetd.d/git":
		mode	=> 644,
		owner	=> root,
		group	=> root,
		require	=> Package["git-daemon"],
		ensure	=> present,
		source	=> "puppet:///git/xinetd_git",
		notify	=> Service["xinetd"]
	}

	file { "/etc/httpd/conf.d/git.conf":
		mode	=> 644,
		owner	=> root,
		group	=> root,
		require	=> Package["gitweb"],
		source	=> "puppet:///git/http_git.conf",
		notify	=> Service["apache"]
	}

	file { "/pub":
		mode	=> 755,
		owner	=> root,
		group	=> root,
		ensure	=> directory,
		require	=> Package["git"]
	}

	file { "/pub/git":
		mode	=> 755,
		owner	=> root,
		group	=> root,
		ensure	=> directory,
		require	=> File["/pub"]
	}
}
