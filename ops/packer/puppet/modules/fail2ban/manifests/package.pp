# Class: fail2ban::package
#
#
class fail2ban::package (

	$package_name = $fail2ban::params::package_name

	) {
	# resources
	package { 'fail2ban':
		name   => $package_name,
		ensure => installed,
	}
}