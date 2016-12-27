class minecraft::server_properties {

  file { 'server.properties' :
    ensure  => file,
    path    => "${minecraft::install_dir}/server.properties",
    owner   => $minecraft::user,
    group   => $minecraft::group,
    mode    => '0664',
    require => User[$minecraft::user],
  }

  # set defaults in case need to break up augeas changes
  Augeas {
    lens    => 'Properties.lns',
    incl    => "${minecraft::install_dir}/server.properties",
    require => File['server.properties'],
    notify  => Service['minecraft'],
  }

  augeas { 'base-server-properties' :
    changes => [
     "set generator-settings \"${minecraft::generator_settings}\"",
     "set op-permission-level \"${minecraft::op_permisison_level}\"",
     "set allow-nether \"${minecraft::allow_nether}\"",
     "set enable-query \"${minecraft::enable_query}\"",
     "set allow-flight \"${minecraft::allow_flight}\"",
     "set announce-player-achievements \"${minecraft::announce_achievments}\"",
     "set server-port \"${minecraft::server_port}\"",
     "set level-type \"${minecraft::level_type}\"",     
     "set enable-rcon \"${minecraft::enable_rcon}\"",     
     "set force-gamemode \"${minecraft::force_gamemode}\"",
     "set level-seed \"${minecraft::level_seed}\"",     
     "set server-ip \"${minecraft::server_ip}\"",     
     "set max-build-height \"${minecraft::max_build_height}\"",
     "set spawn-npcs \"${minecraft::spawn_npcs}\"",     
     "set white-list \"${minecraft::white_list}\"",     
     "set spawn-animals \"${minecraft::spawn_animals}\"",
     "set snooper-enabled \"${minecraft::snooper_enabled}\"",     
     "set hardcore \"${minecraft::hardcore}\"",     
     "set online-mode \"${minecraft::online_mode}\"",     
     "set resource-pack \"${minecraft::resource_pack}\"",     
     "set pvp \"${minecraft::pvp}\"",     
     "set difficulty \"${minecraft::difficulty}\"",     
     "set enable-command-block \"${minecraft::enable_command_block}\"",     
     "set player-idle-timeout \"${minecraft::player_idle_timeout}\"",     
     "set max-players \"${minecraft::max_players}\"",     
     "set spawn-monsters \"${minecraft::spawn_monsters}\"",     
     "set generate-structures \"${minecraft::gen_structures}\"",     
     "set view-distance \"${minecraft::view_distance}\"",     
     "set spawn-protection \"${minecraft::spawn_protection}\"",
     "set motd \"${minecraft::motd}\"",
    ],
  }

}
