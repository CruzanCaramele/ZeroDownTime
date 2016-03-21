# Class: ssh
#
#
class ssh (

	$package_name = $ssh::params::package_name,
	$service_name = $ssh::params::service_name,
	$ssh_dir     = $ssh::params::ssh_dir

	) inherits ssh::params {

	include ssh::package
	include ssh::service

	file { $ssh_dir:
		ensure  => directory,
		recurse => true,
	}

	ssh::sshfile {"default":
		ssh_dir => $ssh_dir,
	}
}