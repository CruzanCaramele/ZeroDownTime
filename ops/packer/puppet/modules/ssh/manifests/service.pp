# Class: ssh::service
#
#
class ssh::service (

	$service_name = $ssh::params::service_name

	) {
	# resources
	service { 'ssh':
		name        => $service_name,
		enable      => true,
		ensure      => running,
		require     => Package['ssh'],
		subscribe   => File['sshd_config'],
		#hasrestart => true,
		#hasstatus  => true,
		#require    => Class["config"],
	}
}