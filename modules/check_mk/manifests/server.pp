# /etc/puppet/modules/check_mk/manifests/init.pp

define check_mk::server {
# notify { "omd site = $name": }
  $omd_site_home           = "/opt/omd/sites/${name}"
# notify { "omd site home = $omd_site_home": }
  $check_mk_location       = "${omd_site_home}/etc/check_mk"
  $check_mk_agent_location = "${check_mk_location}/agents"

# $check_mk_server_flag = "/var/lock/check_mk_server"
# $check_mk_server_version = "check_mk-1.1.12p3"

  File<<| tag == 'check_mk_remote' |>>

  exec { "check_mk_update_${name}":
  command => "/bin/su - ${name} -c 'check_mk -I; check_mk -O'",
#   refreshonly => true,
  }

  file { "/conf.d/main_${name}":
    ensure  => directory,
    path    => "${check_mk_location}/conf.d/main",
    purge   => true,
    recurse => true,
    notify  => Exec["check_mk_update_${name}"],
  }

  # check_mk parents

  File <<| tag == 'check_mk_remote_parents' |>>

  exec { "check_mk_parents_${name}":
    command     => "${omd_site_home}/bin/check_mk -O",
    refreshonly => true,
  }

  file { "${check_mk_location}/conf.d/parents":
    ensure  => directory,
    path    => "${check_mk_location}/conf.d/parents",
    purge   => true,
    recurse => true,
    notify  => Exec["check_mk_parents_${name}"],
  }
  file { "${check_mk_location}/main.mk":
    ensure  => present,
    path    => "${check_mk_location}/main.mk",
    mode    => '0644',
    owner   => $name,
    group   => $name,
    content => template('check_mk/main.mk.erb'),
  }

  file { "${check_mk_location}/conf.d/conf-contact.mk":
    ensure => present,
    path   => "${check_mk_location}/conf.d/conf-contact.mk",
    mode   => '0644',
    owner  => $name,
    group  => $name,
    source => 'puppet:///check_mk/conf-contact.mk',
  }

  file { "${check_mk_location}/conf.d/conf-notification.mk":
    ensure => present,
    path   => "${check_mk_location}/conf.d/conf-notification.mk",
    mode   => '0644',
    owner  => $name,
    group  => $name,
    source => 'puppet:///check_mk/conf-notification.mk',
  }

  file { "${omd_site_home}/etc/apache/conf.d/auth.conf":
    ensure  => present,
    path    => "${omd_site_home}/etc/apache/conf.d/auth.conf",
    mode    => '0644',
    owner   => $name,
    group   => $name,
    content => template('check_mk/auth.conf.erb'),
  }

  exec { "omd restart ${name} apache":
    subscribe   => File["${omd_site_home}/etc/apache/conf.d/auth.conf"],
    refreshonly => true
  }

  file { "${omd_site_home}/etc/nagios/conf.d/timeperiods.cfg":
    ensure => present,
    path   => "${omd_site_home}/etc/nagios/conf.d/timeperiods.cfg",
    mode   => '0644',
    owner  => $name,
    group  => $name,
    source => 'puppet:///check_mk/timeperiods.cfg',
  }

  # Add site to cron.allow

  # Add site to access.conf
}
