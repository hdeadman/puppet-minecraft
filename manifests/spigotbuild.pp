class minecraft::spigotbuild (
  $source      = 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar',
  $manage_git  = true,
  $manage_java = true,
  $rev         = '1.11.2',
  $install_dir = '/opt/spigotbuild',
  ) {

  if $manage_java {
	Class['java'] -> Exec['run build tools']
    include java
  }
  
  if $manage_git {
    include git
    git::config { 'core.autocrlf':
      value => 'false',
      scope => 'global',
      before=> Exec['run build tools'],
    }
  }

  archive { 'spigot-buildtools' :
    ensure  => present,
    source  => $source,
    path    => "${install_dir}/BuildTools.jar",
    user    => $::minecraft::user,
    notify  => Exec['run build tools'],
  }

  exec { 'run build tools':
    command     => "java -jar BuildTools.jar -rev ${rev}",
    cwd         => $install_dir,
    path        => ['/usr/bin', '/bin'],
    creates     => "${install_dir}/spigot-${rev}.jar",
    logoutput   => true,
    environment => ["HOME=/root"],
    timeout     => 600,
  }
}