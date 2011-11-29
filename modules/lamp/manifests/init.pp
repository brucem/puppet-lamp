class lamp {

    require augeas
    require php
    require apache
    require php::apache
    require mysql::client
    require mysql::server

   # Setup webserver
    apache::vhost{ "test.com":
        ensure  => present,
        notify  => Exec["apache-graceful"],
        enable_default => false,
        mode    => "02775",
        group   => "www-data",
        user    => "vagrant",
        require => Package['php5-mysql'],
    }

    mysql::rights { 'test':
        ensure   => present,
        user     => 'test',
        password => 'password',
        database => 'test',
    }

    mysql::database { 'test':
        ensure  => present,
        require => Mysql::Rights['test'],
    }

    # Install php modules
    $php_package_list = ["php5-mysql", "php5-gd", "php5-mcrypt", "php5-memcache", "php-apc", "php-pear", "php-xml-parser", "php-mail", "php-log", "php-auth", "php5-curl"]
    package{ $php_package_list:
        ensure  => present,
        notify  => Exec["apache-graceful"]
    }

    # Install any required packages
    $misc_package_list =["git-core"]
    package{ $misc_package_list:
        ensure  => present,
    }

    # Install phpmysqladmin
    package{ "phpmyadmin":
        ensure => present,
    }

    file {"/etc/apache2/conf.d/phpmyadmin.conf":
        ensure => "/etc/phpmyadmin/apache.conf",
        require => Package["phpmyadmin"],
        notify  => Exec["apache-graceful"]
   }
}
