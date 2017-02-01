class rea::app {
    FILE {
        owner   => 'www-data',
        group   => 'www-data',
    }


#####
package { 'unicorn':
  ensure => installed,
}
    package {
        'nginx':
            ensure  => latest,
notify => File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"];
#            notify  => Service['nginx'];
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


#####






    exec {
        'clone_app':
            command     =>  '/usr/bin/git clone https://github.com/rea-cruitment/simple-sinatra-app.git /var/www/simple-sinatra-app',
            refreshonly => true,
            require     => Package['git'],
logoutput => true,
            notify      => Exec['install_app'];
        'install_app':
            command     => '/usr/local/bin/bundle install --gemfile /var/www/simple-sinatra-app/Gemfile',
            refreshonly => true,
            require     => [Package['bundle'],Exec['clone_app']];
	'unicorn_rails':
	   command => '/usr/bin/unicorn_rails -c /var/www/simple-sinatra-app/unicorn.conf.rb -D',
	   unless => "/bin/ps aux | /bin/grep 'unicorn_rails' | /bin/grep -v grep",
           require => [File['/var/www/simple-sinatra-app/unicorn.conf.rb'],Package['unicorn']];
    }
    file {
        ['/var/www', '/var/www/simple-sinatra-app']:
            ensure  => directory,
            mode    => '0755',
            notify  => [Exec['clone_app'],File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"]];
        '/var/log/unicorn':
            ensure  => directory,
            mode    => '0755';
		["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"]:
			ensure => absent;
		'/etc/nginx/conf.d/rea.conf':  
			ensure => present,
			mode => '0755',
			source => 'puppet:///modules/rea/nginx/unicorn.conf',
			require => [Package['nginx'],File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"]],
			notify => Service['nginx'];
		'/var/www/simple-sinatra-app/unicorn.conf.rb':  
			ensure => present,
			mode => '0755',
			source => 'puppet:///modules/rea/unicorn/unicorn.conf.rb',
			require => Exec['clone_app'],
			notify  => Exec['unicorn_rails'];
    }
}
