node 'default' {

  Yumrepo <| |> -> Package <| provider != 'rpm' |>

  $omd_site = 'test'
  include omd::install
  include omd::site::add

  class {'yum':
    extrarepo => ['omd','epel',]
  }
}
