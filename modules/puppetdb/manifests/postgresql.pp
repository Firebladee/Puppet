# Class puppetdb::postgresql
#
# Configures PostGreSQL grants for PuppetDB
#
class puppetdb::postgresql {

  case $puppetdb::db_host {
    'localhost','127.0.0.1': {
      postgresql::dbcreate { $puppetdb::db_name:
        role     => $puppetdb::db_user,
        password => $puppetdb::db_password,
        address  => $puppetdb::db_host,
      }
    }
    default: {
      @@postgresql::dbcreate { $puppetdb::db_name:
        role     => $puppetdb::db_user,
        password => $puppetdb::db_password,
        address  => $puppetdb::db_host,
        tag      => "mysql_grants_${puppetdb::db_host}",
      }
    }
  }

}
