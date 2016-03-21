# Class: apache
#
#
class apache (

	$servername    = $apache::params::servername,
	$document_root = $apache::params::document_root,
	$log_dir	   = $apache::params::log_dir,
	$package_name  = $apache::params::package_name,
	$service_name  = $apache::params::service_name,
	$conf_dir      = $apache::params::conf_dir,
	$vhost_dir	   = $apache::params::vhost_dir,
	$webapp_dir    = $apache::params::webapp_dir,
	$managerepo    = $apache::params::managerepo

	) inherits apache::params {
	# resources

	include apache::package
	include apache::service

	file { $document_root:
		ensure   => directory,
		recurse => true,
	}

	file { $log_dir:
		ensure   => directory,
		recurse => true,
	}

	apache::vhost {"default":
		port 		  => 80,
		document_root => $document_root,
		servername    => $servername,
		vhost_dir     => $vhost_dir,
		webapp_dir    => $webapp_dir,
		managerepo    => $managerepo,
	}	
}