# /etc/puppet/modules/test/manifests/params.pp

class test::params {

	$omd_site	= $::test_omd_site ? {
		''	=> 'ALL',	# Default value
		default	=> $::test_omd_site,
	}

	$install	= $::test_install ? {
		''	=> 'agent',	# Default value
		default	=> $::test_install,
	}

	$parents	= $::test_parents ? {
		''	=> '',		# Default value
		default	=> $::test_parents,
	}

	$check_mk_tags		= $::test_check_mk_tags ? {
		''	=> '',		# Default value
		default	=> $::test_check_mk_tags,
	}
}
