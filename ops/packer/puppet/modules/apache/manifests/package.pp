# Class: apache::package
#
#
class apache::package (

	$package_name = $apache::params::package_name

	) {
	# resources

	package { 'apache':
		name   => $package_name,
		ensure => installed,
	}
}