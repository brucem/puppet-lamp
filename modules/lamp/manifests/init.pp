class lamp {

    require augeas
    require php
    require apache
    require php::apache
    require mysql::client
    require mysql::server

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
}
