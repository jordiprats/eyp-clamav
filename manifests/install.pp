class clamav::install inherits clamav {

  if($clamav::manage_package)
  {
    package { $clamav::params::package_name:
      ensure => $clamav::package_ensure,
    }
  }

}
