# /etc/puppet/modules/test/manifests/params.pp

class check_mk::params {

	$omd_site	= $::check_mk_omd_site ? {
		''	=> 'ALL',	# Default value
		default	=> $::check_mk_omd_site,
	}

	$install	= $::check_mk_install ? {
		''	=> 'agent',	# Default value
		default	=> $::check_mk_install,
	}

	$parents	= $::check_mk_parents ? {
		''	=> '',		# Default value
		default	=> $::check_mk_parents,
	}

	$check_mk_tags	= $::check_mk_check_mk_tags ? {
		''	=> '',		# Default value
		default	=> $::check_mk_check_mk_tags,
	}

	$check_mk_alias         = $::check_mk_check_mk_alias ? {
                ''      => '',          # Default value
                default => $::check_mk_check_mk_alias,
        }
}
