class io_heartbeat::host (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $pia_domain_list           = $io_heartbeat::pia_domain_list,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $hostname                  = $io_heartbeat::hostname,
  $fqdn                      = $io_heartbeat::fqdn
) inherits io_heartbeat {
  notify { "Create Heartbeat monitors for ${hostname}": }

  file { "${monitor_location}/${hostname}-${service_name}.yml" :
    ensure  => file,
    content => template('io_heartbeat/host.yml.erb'),
    owner   => $psft_runtime_user_name,
    group   => $psft_runtime_group_name,
    mode    => '0644',
  }
}
