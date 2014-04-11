
class vagrant {

  file { '/etc/hosts':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vagrant/hosts.erb'),
  }

}
