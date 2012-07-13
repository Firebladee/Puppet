# /etc/puppet/modules/users/manifests/deluser.pp

define deluser {
        user { "$name":
		ensure   => absent,
        }
}

