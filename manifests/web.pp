class io_heartbeat::pia (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $pia_domain_list           = $io_heartbeat::pia_domain_list,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $pia                       = $io_heartbeat::pia,
  $hostname                  = $io_heartbeat::hostname,
  $fqdn                      = $io_heartbeat::fqdn
) inherits io_heartbeat {
  $pia_domain_list.each |$domain_name, $pia_domain_info| {

    notify { "Create Heartbeat monitors for ${domain_name}": }
    $pia_http_port = $pia_domain_info[webserver_settings][webserver_http_port]

    file { "${monitor_location}/${hostname}-pia-${domain_name}.yml" :
      ensure  => file,
      content => template('io_heartbeat/web.yml.erb'),
      owner   => $psft_runtime_user_name,
      group   => $psft_runtime_group_name,
      mode    => '0644',
    }

    file { "${monitor_location}/${hostname}-${service_name}.yml" :
      ensure  => file,
      content => template('io_heartbeat/host.yml.erb'),
      owner   => $psft_runtime_user_name,
      group   => $psft_runtime_group_name,
      mode    => '0644',
    }
  }
}
