# /etc/puppet/modules/nagios/manifests/plugin.pp

define nagios::plugin ( $enable="yes" ) {

   include nagios::params
   include nrpe::params

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

   file { "Nagios_plugin_${name}":
        path    => "${nrpe::params::pluginsdir}/${name}",
        owner   => root,
        group   => root,
        mode    => 755,
        ensure  => "${ensure}",
        source  => "${nagios::params::general_base_source}/nagios/nagios-plugins/${name}",
   }

}

