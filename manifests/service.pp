class clamav::service inherits clamav {

  #
  validate_bool($clamav::manage_docker_service)
  validate_bool($clamav::manage_service)
  validate_bool($clamav::service_enable)

  validate_re($clamav::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${clamav::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $clamav::manage_docker_service)
  {
    if($clamav::manage_service)
    {
      service { $clamav::params::service_name:
        ensure => $clamav::service_ensure,
        enable => $clamav::service_enable,
      }
    }
  }
}
