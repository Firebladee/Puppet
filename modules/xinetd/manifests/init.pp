# = Class: xinetd
#
# This is the main xinetd class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, xinetd class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $xinetd_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, xinetd main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $xinetd_source
#
# [*source_dir*]
#   If defined, the whole xinetd configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $xinetd_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $xinetd_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, xinetd main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $xinetd_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $xinetd_options
#
# [*service_autorestart*]
#   Automatically restarts the xinetd service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $xinetd_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $xinetd_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $xinetd_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $xinetd_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for xinetd checks
#   Can be defined also by the (top scope) variables $xinetd_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $xinetd_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $xinetd_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $xinetd_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $xinetd_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for xinetd port(s)
#   Can be defined also by the (top scope) variables $xinetd_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling xinetd. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $xinetd_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $xinetd_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $xinetd_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $xinetd_audit_only
#   and $audit_only
#
# Default class params - As defined in xinetd::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of xinetd package
#
# [*service*]
#   The name of xinetd service
#
# [*service_status*]
#   If the xinetd service init script supports status argument
#
# [*process*]
#   The name of xinetd process
#
# [*process_args*]
#   The name of xinetd arguments. Used by puppi and monitor.
#   Used only in case the xinetd process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user xinetd runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $xinetd_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $xinetd_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include xinetd"
# - Call xinetd as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class xinetd (
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits xinetd::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $xinetd::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $xinetd::bool_disableboot ? {
    true    => false,
    default => $xinetd::bool_disable ? {
      true    => false,
      default => $xinetd::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $xinetd::bool_disable ? {
    true    => 'stopped',
    default =>  $xinetd::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $xinetd::bool_service_autorestart ? {
    true    => 'Service[xinetd]',
    false   => undef,
  }

  $manage_file = $xinetd::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $xinetd::bool_absent == true or $xinetd::bool_disable == true or $xinetd::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $xinetd::bool_absent == true or $xinetd::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $xinetd::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $xinetd::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $xinetd::source ? {
    ''        => undef,
    default   => $xinetd::source,
  }

  $manage_file_content = $xinetd::template ? {
    ''        => undef,
    default   => template($xinetd::template),
  }

  ### Managed resources
  package { 'xinetd':
    ensure => $xinetd::manage_package,
    name   => $xinetd::package,
  }

  service { 'xinetd':
    ensure     => $xinetd::manage_service_ensure,
    name       => $xinetd::service,
    enable     => $xinetd::manage_service_enable,
    hasstatus  => $xinetd::service_status,
    pattern    => $xinetd::process,
    require    => Package['xinetd'],
  }

  file { 'xinetd.conf':
    ensure  => $xinetd::manage_file,
    path    => $xinetd::config_file,
    mode    => $xinetd::config_file_mode,
    owner   => $xinetd::config_file_owner,
    group   => $xinetd::config_file_group,
    require => Package['xinetd'],
    notify  => $xinetd::manage_service_autorestart,
    source  => $xinetd::manage_file_source,
    content => $xinetd::manage_file_content,
    replace => $xinetd::manage_file_replace,
    audit   => $xinetd::manage_audit,
  }

  # The whole xinetd configuration directory can be recursively overriden
  if $xinetd::source_dir {
    file { 'xinetd.dir':
      ensure  => directory,
      path    => $xinetd::config_dir,
      require => Package['xinetd'],
      notify  => $xinetd::manage_service_autorestart,
      source  => $xinetd::source_dir,
      recurse => true,
      purge   => $xinetd::source_dir_purge,
      replace => $xinetd::manage_file_replace,
      audit   => $xinetd::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $xinetd::my_class {
    include $xinetd::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $xinetd::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'xinetd':
      ensure    => $xinetd::manage_file,
      variables => $classvars,
      helper    => $xinetd::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $xinetd::bool_monitor == true {
    monitor::port { "xinetd_${xinetd::protocol}_${xinetd::port}":
      protocol => $xinetd::protocol,
      port     => $xinetd::port,
      target   => $xinetd::monitor_target,
      tool     => $xinetd::monitor_tool,
      enable   => $xinetd::manage_monitor,
    }
    monitor::process { 'xinetd_process':
      process  => $xinetd::process,
      service  => $xinetd::service,
      pidfile  => $xinetd::pid_file,
      user     => $xinetd::process_user,
      argument => $xinetd::process_args,
      tool     => $xinetd::monitor_tool,
      enable   => $xinetd::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $xinetd::bool_firewall == true {
    firewall { "xinetd_${xinetd::protocol}_${xinetd::port}":
      source      => $xinetd::firewall_source,
      destination => $xinetd::firewall_destination,
      protocol    => $xinetd::protocol,
      port        => $xinetd::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $xinetd::firewall_tool,
      enable      => $xinetd::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $xinetd::bool_debug == true {
    file { 'debug_xinetd':
      ensure  => $xinetd::manage_file,
      path    => "${settings::vardir}/debug-xinetd",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
