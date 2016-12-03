class clamav::server::install inherits clamav::server {

  if($clamav::server::manage_package)
  {
    package { $clamav::params::server_package_name:
      ensure => $clamav::server::package_ensure,
    }

    package { $clamav::params::server_initscripts_package:
      ensure => $clamav::server::package_ensure,
    }
  }

}
