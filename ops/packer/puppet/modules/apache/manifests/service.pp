# Class: apache::service
#
#
class apache::service (

	$service_name = $apache::params::service_name

	) {
	# resources

	service { 'apache':
		name        => $service_name,
		enable      => true,
		ensure      => running,
		require     => Package['apache'],
		#hasrestart => true,
		#hasstatus  => true,
		#require    => Class["config"],
	}
}