# Class: ntp::service
#
#
class ntp::service (
	$service_name = $ntp::params::service_name

	) {
	# resources
	service { 'ntp':
		name        => $service_name,
		enable      => true,
		ensure      => running,
		require     => Package["ntp"],
	}

}