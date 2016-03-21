# Class: fail2ban::service
#
#
class fail2ban::service (

	$service_name = $fail2ban::params::service_name

	){
	# resources
	service { 'fail2ban':
		name        => $service_name,
		enable      => true,
		ensure      => running,
		require     => Package['fail2ban'],
		subscribe   => File['jail.local'],
		#hasrestart => true,
		#hasstatus  => true,
		#require    => Class["config"],
	}
}