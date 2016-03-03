# Define: ntp::ntpfile
# Parameters:
# arguments
#
define ntp::ntpfile (
	$file_name, $file_path, $service_name

	) {
	# puppet code
	File {
		mode => 0677,
	}

	file { 'ntptime':
		path   => "${file_path}/ntp.conf",
		ensure => file,
		source => 'puppet:///modules/ntp/ntp.conf',
		notify => Service['ntp'],
	}
}