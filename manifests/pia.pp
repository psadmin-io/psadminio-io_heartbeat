class io_heartbeat::pia (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $pia_domain_list           = $io_heartbeat::pia_domain_list,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $pia_url                   = $io_heartbeat::pia_url,
  $pia_user                  = $io_heartbeat::pia_user,
  $pia_pwd                   = $io_heartbeat::pia_pwd
) inherits io_heartbeat {
  notify { "Create Heartbeat monitors for PIA ${service_name}": }

  file { "${monitor_location}/pia-${service_name}.yml" :
    ensure  => file,
    content => template('io_heartbeat/pia.yml.erb'),
    owner   => $psft_runtime_user_name,
    group   => $psft_runtime_group_name,
    mode    => '0644',
  }
}
