# Class: fail2ban
#
#
class fail2ban (

	$package_name = $fail2ban::params::package_name,
	$service_name = $fail2ban::params::service_name,
	$fail_dir     = $fail2ban::params::fail_dir

	) inherits fail2ban::params {
	# resources
	include fail2ban::service
	include fail2ban::package	

	fail2ban::fail2banfile {"default":
		fail_dir => $fail_dir,
	}
}