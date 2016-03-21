# Class: packages
#
class packages {
	# resources
	$installs = ['python-pip', 'git']

	package { $installs:

		ensure => installed,
	}

	include packages::devpacks
	include packages::pippacks

}