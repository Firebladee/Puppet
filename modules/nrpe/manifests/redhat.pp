# /etc/puppet/modules/nrpe/manifests/redhat.pp

class nrpe::redhat {

    include nrpe::params

    file { "nrpe.init":
        path    => "${nrpe::params::initconfigfile}",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => Package["nrpe"],
        notify  => Service["nrpe"],
        content => template("nrpe/nrpe-init-redhat.erb"),
    }

}
