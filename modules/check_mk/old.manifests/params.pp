# /etc/puppet/modules/check_mk/manifests/params.pp

class check_mk::params {

	$check_mk_location = "/etc/check_mk"
	$check_mk_agent_location = "/etc/check_mk/agents"

}
