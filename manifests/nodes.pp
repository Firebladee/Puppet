node 'default' {

include vagrant

  Yumrepo <| |> -> Package <| provider != 'rpm' |>

  class {'yum':
    extrarepo => ['omd','epel','puppetlabs',]
  }
}

node /^puppet*/ {

}

node /^client1*/ {
  class { 'omd::install':}
  $omd_site = 'test'
  include omd::site::add
}

node /^client2*/ {

}
