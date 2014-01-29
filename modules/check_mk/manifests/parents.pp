# Document me
define check_mk::parents {
  $omd_site_home           = "/opt/omd/sites/${name}"
  $check_mk_location       = "${omd_site_home}/etc/check_mk"
  $check_mk_agent_location = "${check_mk_location}/agents"

  @@file {
    "${check_mk_location}/conf.d/parents/${::hostname}.mk":
#     ensure  => file,
#     content => "parents += [ ("${parent}", [ "${hostname}"])]",
      content => template('check_mk/parents.erb'),
      tag     => 'check_mk_remote_parents'
  }
}
