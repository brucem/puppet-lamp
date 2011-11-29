# Default path
Exec { path => "/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin" }

# Make sure there is a puppet group
group { "puppet": ensure => "present" }

# Set FQDN fir virtualbox
if $virtual == "virtualbox" and $fqdn == '' {
    $fqdn = "localhost"
}
# MYSQL root password
$mysql_password = "setmysqlpasswordhere" 

include lamp
