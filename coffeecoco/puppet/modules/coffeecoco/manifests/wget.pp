# == Define Resource Type: coffeecoco::server::wget
#
# Downloads a remote file.
#
# Usage:
#
# coffeecoco::server::wget { '/download/to/target':
#   source => 'http://source.com/foo.exe',
#   user   => 'user',
#   group  => 'group',
#   mode   => '+x'
# }
#
define coffeecoco::server::wget (
  $source,
  $user  = 'root',
  $group = 'root',
  $mode  = '0644',
){

  $destination = $name

  $cmd = "wget --quiet --tries=5 --connect-timeout=10 -O '${destination}' ${source}"

  exec { "download ${source}":
    creates => $destination,
    command => $cmd,
    timeout => 3600,
    path    => '/usr/bin',
  }
  -> file { $destination:
    ensure => file,
    owner  => $user,
    group  => $group,
    mode   => $mode,
  }

}
