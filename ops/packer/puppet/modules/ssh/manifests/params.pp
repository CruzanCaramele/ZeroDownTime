# Class: ssh::params
#
#
class ssh::params {
	# params
	$package_name = "openssh-server"
	$service_name = "ssh"
	$ssh_path     = "/etc/ssh"
	$ssh_file     = "sshd_config"
}