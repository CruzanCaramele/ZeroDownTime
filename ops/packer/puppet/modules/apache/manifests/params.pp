# Class: apache::params
#
#
class apache::params {
	# parameters
	if ($::fqdn) {
		$servername = $::fqdn
	} else {
		$servername = $::hostname
	}

	$documant_root = "/var/www/html"
	$log_dir       = "/var/log/apache"

	$package_name = "apache2"
	$service_name = "apache2"
	$conf_dir     = "/etc/apache2"
	$vhost_dir    = "/etc/apache2/sites-available/"
	$app_dir      = "/var/www/html"
}