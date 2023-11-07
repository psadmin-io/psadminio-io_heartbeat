class io_heartbeat::web (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $pia_domain_list           = $io_heartbeat::pia_domain_list,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $web_port                  = $io_heartbeat::web_port,
  $hostname                  = $io_heartbeat::hostname,
  $fqdn                      = $io_heartbeat::fqdn
) inherits io_heartbeat {
  $pia_domain_list.each |$domain_name, $pia_domain_info| {
    notify { "Create Heartbeat monitors for web domain ${domain_name}": }

    file { "${monitor_location}/${hostname}-web-${domain_name}.yml" :
      ensure  => file,
      content => template('io_heartbeat/web.yml.erb'),
      owner   => $psft_runtime_user_name,
      group   => $psft_runtime_group_name,
      mode    => '0644',
    }
  }
}
