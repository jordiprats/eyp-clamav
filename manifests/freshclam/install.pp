class clamav::freshclam::install inherits clamav::freshclam {

  if($clamav::freshclam::manage_package)
  {
    package { $clamav::params::freshclam_package_name:
      ensure => $clamav::freshclam::package_ensure,
    }
  }

}
