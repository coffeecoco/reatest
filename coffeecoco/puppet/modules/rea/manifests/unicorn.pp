class rea::unicorn {
    FILE {
        owner   => 'root',
        group   => 'root',
    }
package { 'unicorn':
  ensure => installed,
}
    package {
        'nginx':
            ensure  => latest,
            notify  => Service['nginx'];
        ['ruby', 'ruby-dev', 'rubygems', 'build-essential']:
            ensure  => latest;
		['sinatra']:
             ensure   => 'latest',
             provider => 'gem';
        'bundle':
            ensure      => latest,
            require     => Package['rubygems'],
            provider    => 'gem';
    }
    service {
        'nginx':
            ensure  => running,
            require => Package['nginx'];
    }

}
