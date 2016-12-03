define clamav::server::instance::config(
                                          $user             = 'amavis',
                                          $pidfile          = "/var/run/${instancename}_clamd.pid",
                                          $socket           = "/var/run/${instancename}_clamd.sock",
                                          $fix_stale_socket = true,
                                          $log_syslog       = true,
                                          $log_facility     = 'LOG_MAIL',
                                        ) {
  #
  file { "/etc/clamd.d/${instancename}.conf":
    ensure => 'present',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template("${module_name}/server/clamdconf.erb"),
  }
}
