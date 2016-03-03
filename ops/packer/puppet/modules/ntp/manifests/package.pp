# Class: ntp::package (

#
class ntp::package (
	$package_name = $ntp::params::package_name

	) {
	# resources
	package { 'npt':
		name   => $package_name,
		ensure => installed,
	}
}