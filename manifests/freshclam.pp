class clamav::freshclam(
                          $manage_package = true,
                          $package_ensure = 'installed',
                          $mailto         = undef,
                        ) inherits clamav::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  include ::clamav

  class { '::clamav::freshclam::install': } ->
  class { '::clamav::freshclam::config': } ->
  Class['::clamav::freshclam']

}
