# /etc/puppet/modules/yum/manifests/params.pp

class yum::params  {

# Manage Automatic Updates method
  $update = $yum_update ? {
    'cron'     => 'cron',
    'updatesd' => 'updatesd',
    default    => 'off',
  }

  $extrarepo = $yum_extrarepo
}
