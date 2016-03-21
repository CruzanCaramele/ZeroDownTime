# Define: fail2ban::fail2banfile
# Parameters:
# arguments
#
define fail2ban::fail2banfile ($fail_dir) {
	# puppet code
	file { 'jail.local':
		path   => '${fail_dir}/jail.local',
		ensure => file,
		source => 'puppet:///modules/fail2ban/jail.local',
		require => Package['fail2ban'],
	}
}