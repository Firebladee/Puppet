# Class: puppetdashboard::params
#
# This class defines default parameters used by the main module class puppetdashboard
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to puppetdashboard class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class puppetdashboard::params {

  ### Module's specific parameters

  $db_name = 'dashboard_production'
  $db_user = 'dashboard'
  $db_password = 'dashboard'

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'puppet-dashboard',
  }

  $service = $::operatingsystem ? {
    default => 'puppet-dashboard',
  }

  $service_workers = $::operatingsystem ? {
    default => 'puppet-dashboard-workers',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'ruby',
  }

  $process_args = $::operatingsystem ? {
    default => 'puppet-dashboard',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'www-data',
    default                   => 'httpd',
  }

  $config_dir = $::operatingsystem ? {
    default => '/usr/share/puppet-dashboard/config',
  }

  $config_file = $::operatingsystem ? {
    default => '/usr/share/puppet-dashboard/config/settings.yml',
  }

  $config_file_db = $::operatingsystem ? {
  #  default => '/etc/puppet-dashboard/database.yml',
    default => '/usr/share/puppet-dashboard/config/database.yml',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/puppet-dashboard',
    default                   => '/etc/sysconfig/puppet-dashboard',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/puppet-dashboard.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/usr/share/puppet-dashboard/db',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/puppet-dashboard',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/puppet-dashboard/puppet-dashboard.log',
  }

  $port = '3000'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = 'false'
  $template = 'puppetdashboard/settings.yml'
  $template_db = 'puppetdashboard/database.yml'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
