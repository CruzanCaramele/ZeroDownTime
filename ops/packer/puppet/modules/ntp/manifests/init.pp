# Class: ntp 
#
#
class ntp (
	$package_name = $ntp::params::package_name,
	$service_name = $ntp::params::service_name,
	$file_path    = $ntp::params::file_path,
	$file_name    = $ntp::params::file_name

	) inherits ntp::params {
	# classes
	include ntp::service
	include ntp::package

	ntp::ntpfile {"default":
		file_path    => $file_path,
		file_name    => $file_name,
		service_name => $service_name,
	}
}