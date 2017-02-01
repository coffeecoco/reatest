class coffeecoco  (
  $extra_config_files = []
) {


  Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }

  include ::coffeecoco::server
  include rea
#  include ::coffeecoco::ruby

}
