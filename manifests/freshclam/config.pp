class clamav::freshclam::config inherits clamav::freshclam {

  file { '/etc/cron.d/clamav-update':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/freshclam/cronjob.erb"),
  }

  file { '/etc/freshclam.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/freshclam/freshclamconf.erb"),
  }

  file { $freshclam_sysconfig:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($freshclam_sysconfig_template),
  }

}
