class io_heartbeat (
  $ensure                    = lookup('ensure', undef, undef, 'present'),
  $psft_runtime_user_name    = lookup('psft_runtime_user_name', undef, undef, 'psadm2'),
  $psft_runtime_group_name   = lookup('psft_runtime_group_name', undef, undef, 'oinstall'),
  $pia_domain_list           = lookup('pia_domain_list', undef, undef, ''),
  $appserver_domain_list     = lookup('appserver_domain_list', undef, undef, ''),
  $jolt_port                 = lookup('jolt_port', undef, undef, ''),
  $hostname                  = $::hostname,
  $fqdn                      = $::fqdn,
  $monitor_location          = undef,
  $service_name              = lookup('io_heartbeat::service_name', undef, undef, 'peoplesoft'),
  $web_port                  = lookup('io_heartbeat::web_port', undef, undef, '8000'),
  $app_port                  = lookup('io_heartbeat::app_port', undef, undef, '9033'),
  $pia_url                   = lookup('io_heartbeat::pia_url', undef, undef, ''),
  $pia_user                  = lookup('io_heartbeat::pia_user', undef, undef, ''),
  $pia_pwd                   = lookup('io_heartbeat::pia_pwd', undef, undef, ''),
  $igw_url                   = lookup('io_heartbeat::igw_url', undef, undef, ''),
  $web                       = undef,
  $app                       = undef,
  $pia                       = undef,
  $igw                       = undef,
) {
  contain ::io_heartbeat::host

  if ($pia) {
    contain ::io_heartbeat::pia
  }
  if ($igw) {
    contain ::io_heartbeat::igw
  }
  if ($web) {
    contain ::io_heartbeat::web
  }
  if ($app) {
    contain ::io_heartbeat::app
  }
}
