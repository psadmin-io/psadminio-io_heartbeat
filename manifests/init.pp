class io_heartbeat (
  $ensure                    = lookup('ensure', undef, undef, 'present'),
  $psft_runtime_user_name    = lookup('psft_runtime_user_name', undef, undef, 'psadm2'),
  $psft_install_user_name    = lookup('psft_install_user_name', undef, undef, 'psadm1'),
  $pia_domain_list           = lookup('pia_domain_list', undef, undef, ''),
  $appserver_domain_list     = lookup('appserver_domain_list', undef, undef, ''),
  $hostname                  = $::hostname,
  $fqdn                      = $::fqdn,
  $monitor_location          = undef,
  $service_name              = lookup('io_heartbeat::service_name', undef, undef, 'peoplesoft'),
  $web                       = undef,
  $appserver                 = undef
) {
  case $::osfamily {
    'windows': {
      $library_platform = 'Windows'
    }
    default: {
      $library_platform = 'Unix'
    }
  }

  if ($web) {
    contain ::io_heartbeat::web
  }
  if ($appserver) {
    contain ::io_heartbeat::appserver
  }
}
