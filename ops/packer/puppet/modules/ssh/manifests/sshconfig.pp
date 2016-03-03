# Define: ssh::sshconfig
# Parameters:
# arguments
#
define ssh::sshconfig ($ssh_path) {
	# puppet code
	file { 'sshd_config':
	 	path    => "${ssh_path}/sshd_config",
		ensure  => file,
		content => 'puppet:///modules/ssh/sshd_config',
		require => Package['ssh'],
	}

}