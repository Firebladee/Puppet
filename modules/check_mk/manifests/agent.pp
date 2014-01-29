# Document me

define check_mk::agent (
  $check_mk_tags  = $check_mk::params::check_mk_tags,
  $check_mk_alias = $check_mk::params::check_mk_alias,
) {

  $omd_site_home           = "/opt/omd/sites/${name}"
  $check_mk_location       = "${omd_site_home}/etc/check_mk"
  $check_mk_agent_location = "${check_mk_location}/agents"

  @@file {
    "${check_mk_location}/conf.d/main/${::hostname}.mk":
      ensure  => file,
      content => template('check_mk/main.erb'),
      tag     => 'check_mk_remote'
  }
}
