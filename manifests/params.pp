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
        /^[5-6].*$/:
        {
          $server_initscripts_package='clamav-server-sysvinit'
          $freshclam_sysconfig='/etc/sysconfig/freshclam'
          $freshclam_sysconfig_template="${module_name}/freshclam/sysconfig/rh.erb"
          $systemd=false
        }
        /^7.*$/:
        {
          $server_initscripts_package='clamav-server-systemd'
          $freshclam_sysconfig='/etc/sysconfig/freshclam'
          $freshclam_sysconfig_template="${module_name}/freshclam/sysconfig/rh.erb"
          $systemd=true
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
              fail('TODO')
              # root@ubuntu14:~# apt-cache search clamav
              # amavisd-new - Interface between MTA and virus scanner/content filters
              # libclamav6 - anti-virus utility for Unix - library
              # libclamunrar6 - anti-virus utility for Unix - unrar support
              # amavisd-new-postfix - part of Ubuntu mail stack provided by Ubuntu server team
              # clamassassin - email virus filter wrapper for ClamAV
              # clamav-unofficial-sigs - update script for 3rd-party clamav signatures
              # clamfs - user-space anti-virus protected file system
              # clamsmtp - virus-scanning SMTP proxy
              # clamtk - graphical front-end for ClamAV
              # claws-mail-clamd-plugin - ClamAV socket-based plugin for Claws Mail
              # courier-filter-perl - purely Perl-based mail filter framework for the Courier MTA
              # havp - HTTP Anti Virus Proxy
              # libc-icap-mod-clamav - transitional dummy package
              # libc-icap-mod-virus-scan - Antivirus Service for c-icap
              # libclamav-client-perl - Perl client for the ClamAV virus scanner daemon
              # nagios-plugins-contrib - Plugins for nagios compatible monitoring systems
              # proftpd-mod-clamav - ProFTPD module mod_clamav
              # python-clamav - Python bindings to ClamAV - transitional package
              # python-pyclamav - Python bindings to ClamAV
              # python-pyclamd - Python interface to the ClamAV daemon
              # clamav - anti-virus utility for Unix - command-line interface
              # clamav-base - anti-virus utility for Unix - base package
              # clamav-daemon - anti-virus utility for Unix - scanner daemon
              # clamav-dbg - debug symbols for ClamAV
              # clamav-docs - anti-virus utility for Unix - documentation
              # clamav-freshclam - anti-virus utility for Unix - virus database update utility
              # libclamav-dev - anti-virus utility for Unix - development files
              # libclamav7 - anti-virus utility for Unix - library
              # libclamunrar7 - anti-virus utility for Unix - unrar support
              # clamav-milter - anti-virus utility for Unix - sendmail integration
              # clamav-testfiles - anti-virus utility for Unix - test files
              # clamtk-nautilus - Nautilus MenuProvider extension for clamtk
              # python3-pyclamd - Python 3 interface to the ClamAV daemon
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
