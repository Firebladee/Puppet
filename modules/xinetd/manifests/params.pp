# Class: xinetd::params
#
# This class defines default parameters used by the main module class xinetd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to xinetd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class xinetd::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'xinetd',
  }

  $service = $::operatingsystem ? {
    default => 'xinetd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'xinetd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'xinetd',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/xinetd.d',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/xinetd.conf',
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
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/xinetd',
    default                   => '/etc/sysconfig/xinetd',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/xinetd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/messages',
  }

  $port = ''
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = ''
  $options = ''
  $service_autorestart = true
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
