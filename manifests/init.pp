class clamav(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                          ) inherits clamav::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::clamav::install': } ->
  class { '::clamav::config': } ->
  Class['::clamav']

  # SELinux?
  # setsebool -P antivirus_can_scan_system 1

}
