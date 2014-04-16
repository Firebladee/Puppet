node 'default' {

include vagrant

  Yumrepo <| |> -> Package <| provider != 'rpm' |>

  class {'yum':
    extrarepo => ['omd','epel','puppetlabs',]
  }
}
