class io_heartbeat::igw (
  $ensure                    = $io_heartbeat::ensure,
  $psft_runtime_user_name    = $io_heartbeat::psft_runtime_user_name,
  $psft_runtime_group_name   = $io_heartbeat::psft_runtime_group_name,
  $monitor_location          = $io_heartbeat::monitor_location,
  $service_name              = $io_heartbeat::service_name,
  $igw_url                   = $io_heartbeat::igw_url
) inherits io_heartbeat {
  notify { "Create Heartbeat monitors for IGW ${service_name}": }

  file { "${monitor_location}/igw-${service_name}.yml" :
    ensure  => file,
    content => template('io_heartbeat/igw.yml.erb'),
    owner   => $psft_runtime_user_name,
    group   => $psft_runtime_group_name,
    mode    => '0644',
  }
}
