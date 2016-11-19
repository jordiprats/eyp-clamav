class clamav::freshclam::install inherits clamav::freshclam {

  if($clamav::server::manage_package)
  {
    package { $clamav::params::server_package_name:
      ensure => $clamav::server::package_ensure,
    }
  }

}
