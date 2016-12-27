class minecraft::packages {

  if $::minecraft::manage_java {
    class { '::java':
      distribution => 'jre',
      version      => 'latest',
    }
  }

  # systemd unit file uses tmux, init script uses screen
  if $::minecraft::use_systemd_service {
    ensure_packages('tmux')
  } else {
    ensure_packages('screen')
  }
}
