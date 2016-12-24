class minecraft::properties {

  if $minecraft::manage_server_props {
    include minecraft::server_properties
  }

  if $minecraft::ops != undef {
    minecraft::server_setting { 'ops.txt': }
  }

  if $minecraft::banned_players != undef {
    minecraft::server_setting { 'banned-players.txt': }
  }

  if $minecraft::banned_ips != undef {
    minecraft::server_setting { 'banned-ips.txt': }
  }

  if $minecraft::white_list_players != undef {
    minecraft::server_setting { 'white-list.txt': }
  }
}
