class clamav::params {

  $server_service_name = 'clamavd'
  $freshclam_service_name = 'freshclamd'

  $package_name = 'clamav'
  $server_package_name = 'clamav-server'
  $freshclam_package_name = 'clamav-update'

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
          $freshclam_sysconfig='/etc/sysconfig/freshclam'
          $freshclam_sysconfig_template="${module_name}/freshclam/sysconfig/rh.erb"
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
