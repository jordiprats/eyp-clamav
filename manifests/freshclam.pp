class clamav::freshclam(
                          $manage_package = true,
                          $package_ensure = 'installed',
                          $mailto         = undef,
                          $maxattempts    = '5',
                          $dbchecks       = '24',
                        ) inherits clamav::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  include ::clamav

  Class['::clamav'] ->
  class { '::clamav::freshclam::install': } ->
  class { '::clamav::freshclam::config': } ->
  Class['::clamav::freshclam']

}
