class clamav::freshclam::service inherits clamav::freshclam {

  #
  validate_bool($clamav::freshclam::manage_docker_service)
  validate_bool($clamav::freshclam::manage_service)
  validate_bool($clamav::freshclam::service_enable)

  validate_re($clamav::freshclam::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${clamav::freshclam::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $clamav::freshclam::manage_docker_service)
  {
    if($clamav::freshclam::manage_service)
    {
      service { $clamav::params::freshclam_service_name:
        ensure => $clamav::freshclam::service_ensure,
        enable => $clamav::freshclam::service_enable,
      }
    }
  }
}
