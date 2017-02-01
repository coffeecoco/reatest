# Class for installing ruby via rvm
#
class coffeecoco::ruby {

  include ::coffeecoco::params

  $ruby = $coffeecoco::params::hiera['ruby']

  include ::gnupg
  include ::rvm::params

  Class['::rvm']
  -> Coffeecoco::Ruby::Dotfile <| |>
  -> Coffeecoco::Ruby::Install <| |>

  gnupg_key { "rvm_${::rvm::params::gnupg_key_id}":
    ensure     => present,
    key_id     => $::rvm::params::gnupg_key_id,
    user       => 'root',
    key_source => 'https://rvm.io/mpapis.asc',
    key_type   => public,
  }
  -> class { '::rvm':
    key_server   => undef,
    gnupg_key_id => false,
  }

  if ! defined(Group['rvm']) {
    group { 'rvm':
      ensure => present
    }
  }

  exec { 'rvm rvmrc warning ignore all.rvmrcs':
    command => 'rvm rvmrc warning ignore all.rvmrcs && touch /.coffeecoco-stuff/rvmrc',
    creates => '/.coffeecoco-stuff/rvmrc',
    path    => '/bin:/usr/bin:/usr/local/bin:/usr/local/rvm/bin',
    require => Exec['system-rvm'],
  }

  User <| title == $::ssh_username |> {
    groups +> 'rvm'
  }

  if array_true($ruby, 'versions') and count($ruby['versions']) > 0 {
    coffeecoco::ruby::dotfile { 'do': }

    create_resources(coffeecoco::ruby::install, $ruby['versions'])
  }

}

