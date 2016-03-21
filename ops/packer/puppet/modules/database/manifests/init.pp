# Class: database
#
#
class database {
	# resources
    class { 'postgresql::globals':
        version             => '9.4',
        manage_package_repo => true,
        encoding            => 'UTF8',
        locale              => 'en_US.UTF-8',
    }->
    class { 'postgresql::server':
		ip_mask_allow_all_users    => '0.0.0.0/0',
		listen_addresses           => '*',
		postgres_password          => 'Port99',
    }

    # install the postgresql contrib package
    class { 'postgresql::server::contrib':
        package_ensure => 'present',
    }

    # create database with user and default permissions
    postgresql::server::db { 'culturely':
        user     => 'culture',
        password => 'cultural',
    }

}