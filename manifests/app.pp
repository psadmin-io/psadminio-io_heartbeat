class io_heartbeat::app (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $appserver_domain_list     = $io_heartbeat::appserver_domain_list,
  $app_port                  = $io_heartbeat::app_port,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $hostname                  = $io_heartbeat::hostname,
  $fqdn                      = $io_heartbeat::fqdn
) inherits io_heartbeat {
  $appserver_domain_list.each |$domain_name, $appserver_domain_info| {
    notify { "Create Heartbeat monitors for app domain ${domain_name}": }

    file { "${monitor_location}/${hostname}-app-${domain_name}.yml" :
      ensure  => file,
      content => template('io_heartbeat/app.yml.erb'),
      owner   => $psft_runtime_user_name,
      group   => $psft_runtime_group_name,
      mode    => '0644',
    }
  }
}
