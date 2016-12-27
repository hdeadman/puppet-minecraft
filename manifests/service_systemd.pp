class minecraft::service_systemd {

  file { 'minecraft service unit':
    ensure  => present,
    path    => '/etc/systemd/system/minecraft.service',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($minecraft::systemd_template),
  }

  exec { "refresh minecraft service":
    command     => 'systemctl daemon-reload',
    refreshonly => true,
    subscribe   => File['minecraft service unit'],
    path        => ['/bin', '/usr/bin'],
    notify      => Service['minecraft']
  }

  service { 'minecraft':
    ensure    => running,
    enable    => $minecraft::autostart,
  }
  
  # remove non-systemd init script
  file { 'minecraft_init':
    ensure  => absent,
    path    => '/etc/init.d/minecraft',
  }

}