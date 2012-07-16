# Class puppetdashboard::mysql 
# 
# Manages Mysql on Puppet Dahsboard.
#
class puppetdashboard::mysql inherits puppetdashboard {

  include mysql
  mysql::grant { "puppetdashboard_grants_${fqdn}":
    mysql_db         => $puppetdashboard::db_name,
    mysql_user       => $puppetdashboard::db_user,
    mysql_password   => $puppetdashboard::db_password,
    mysql_privileges => 'ALL',
    mysql_host       => 'localhost',
  }

  exec { 'puppetdashboard_dbmigrate':
    cwd         => $puppetdashboard::data_dir,
    command     => 'rake RAILS_ENV=production db:migrate',
    require     => Mysql::Grant["puppetdashboard_grants_${fqdn}"], 
    refreshonly => true,
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
  }
}
