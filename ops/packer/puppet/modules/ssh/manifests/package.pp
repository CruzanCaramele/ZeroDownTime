# Class: ssh::package
#
#
class ssh::package (

	$package_name = $ssh::params::package_name

	) {
	# resources
	package { 'ssh':
		name   => $package_name,
		ensure => installed,
	}
}