define clamav::server::instance(
                                  $manage_service        = true,
                                  $manage_docker_service = true,
                                  $service_ensure        = 'running',
                                  $service_enable        = true,
                                  $instancename          = $name,
                                  $user                  = 'amavis',
                                  $pidfile               = "/var/run/clamd.${name}/clamd.pid",
                                  $socket                = "/var/run/clamd.${name}/clamd.sock",
                                  $fix_stale_socket      = true,
                                  $log_syslog            = true,
                                  $log_facility          = 'LOG_MAIL',
                                ) {

  validate_bool($manage_docker_service)
  validate_bool($manage_service)
  validate_bool($service_enable)

  validate_re($service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  file { "/etc/clamd.d/${instancename}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/server/clamdconf.erb"),
    require => Class['::clamav::server'],
  }

  if( $is_docker_container==false or
      $manage_docker_service)
  {
    if($manage_service)
    {
      if($clamav::params::systemd)
      {
        service { "clamd@${instancename}":
          ensure  => $service_ensure,
          enable  => $service_enable,
          require => File["/etc/clamd.d/${instancename}.conf"],
        }
      }
      else {
        fail('not implemented')
      }
    }
  }

}
