# /etc/puppet/modules/nrpe/manifests/extra.pp

class nrpe::extra {

    file { "extra.cfg":
        path    => "${nrpe::params::configdir}/extra.cfg",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => File["nrpe.d"],
        notify  => Service["nrpe"],
        content => template("nrpe/extra.cfg.erb"),
    }

}
