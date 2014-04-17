node 'default' {

include vagrant

  Yumrepo <| |> -> Package <| provider != 'rpm' |>

  class {'yum':
    extrarepo => ['omd','epel','puppetlabs',]
  }
}

node /^puppet\.example\.com$/ inherits default {

}

node /^client1\.example\.com$/ inherits default {
  class { 'omd::install':}
  $omd_site = 'test'
  include omd::site::add

  class {'check_mk':
    install  => 'server',
    omd_site => 'test',
  }
}

node /^client2\.example\.com$/ inherits default {
  class {'check_mk':
    install  => 'agent',
    omd_site => 'test',
  }
}
