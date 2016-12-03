define clamav::server::instance(
                                  $manage_service        = true,
                                  $manage_docker_service = true,
                                  $service_ensure        = 'running',
                                  $service_enable        = true,
                                  $instancename          = $name,
                                  $user                  = 'amavis',
                                  $pidfile               = "/var/run/${instancename}_clamd.pid",
                                  $socket                = "/var/run/${instancename}_clamd.sock",
                                  $fix_stale_socket      = true,
                                  $log_syslog            = true,
                                  $log_facility          = 'LOG_MAIL',
                                ) {
  #
  clamav::server::instance::config { $instancename:
    user             => $user,
    pidfile          => $pidfile,
    socket           => $socket,
    fix_stale_socket => $fix_stale_socket,
    log_syslog       => $log_syslog,
    log_facility     => $log_facility,
    require          => Class['::clamav::server'],
  } ~>

  clamav::server::instance::service { $instancename:
    manage_service        => $manage_service,
    manage_docker_service => $manage_docker_service,
    service_ensure        => $service_ensure,
    service_enable        => $service_enable,
  }

}
