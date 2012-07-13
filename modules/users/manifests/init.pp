# /etc/puppet/modules/users/manifests/adduser.pp

define users::add ( $uid='', $gid='', $shell='/bin/bash', $home='', $comment='', $password='', $groups='' ) {

	group { "$gid":
		ensure  => "present",
	}

        user { "$name":
                uid      => $uid,
                gid      => $gid,
                shell    => $shell,
                comment  => $comment,
                home     => $home,
                password => $password,
                groups   => $groups,
                ensure   => present,
        }

#	exec { "mkdir $home":
#		command => "mkdir $home; chown -R $name:$gid $home",
#		unless  => "test -d $home",
#	}
}

