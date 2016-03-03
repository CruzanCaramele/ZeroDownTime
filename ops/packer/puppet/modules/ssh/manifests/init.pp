# Class: ssh
#
#
class ssh (

	$package_name = $ssh::params::package_name,
	$service_name = $ssh::params::service_name,
	$ssh_path     = $ssh:params::ssh_path,
	$ssh_file     = $ssh::params::ssh_file
	
	) inherits ssh::params {
	# resources
	include ssh::service
	include ssh:package

	file { $ssh_path:
		ensure  => directory,
		recurse => true,
	}

	ssh::sshconfig {"default":
		ssh_path => $ssh_path,
	}

}