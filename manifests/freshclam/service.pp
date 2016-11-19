class clamav::server::service inherits clamav::server {

  #
  validate_bool($clamav::server::manage_docker_service)
  validate_bool($clamav::server::manage_service)
  validate_bool($clamav::server::service_enable)

  validate_re($clamav::server::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${clamav::server::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $clamav::server::manage_docker_service)
  {
    if($clamav::server::manage_service)
    {
      service { $clamav::server::params::service_name:
        ensure => $clamav::server::service_ensure,
        enable => $clamav::server::service_enable,
      }
    }
  }
}
