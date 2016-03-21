# Define: ssh::sshfile
# arguments
#
define ssh::sshfile (

	$ssh_dir

	) {
	# puppet code
	file { 'sshd_config':
		path    => "${ssh_dir}/sshd_config",
		ensure  => file,
		source  => 'puppet:///modules/ssh/sshd_config',
		require => Package['ssh'],
	}
}