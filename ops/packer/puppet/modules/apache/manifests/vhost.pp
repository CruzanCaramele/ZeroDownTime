# Define: apache::vhost
# Parameters:
# arguments
#
define apache::vhost (
	
	$port, $document_root, $servername, $vhost_name = '*', $vhost_dir

	) {
	# puppet code

File {
		mode => 0677,
	}
		# enter puppet code
		vcsrepo { $app_dir:
        	ensure   => latest,
            provider => git,
            source   => 'https://github.com/CruzanCaramele/ZeroDownTime',
            revision => 'master',
            force    => true,
            require  => Package['apache'],
            notify   => Service['apache'],
            before   => File['config_file'],
    	}
	
	file { 'config_file':
		path    => "${vhost_dir}/000-default.conf",
		ensure  => file,
		content => template('apache/vhost.conf.erb'),
		require => Package['apache'],
		notify  => Service['apache'],
	}

	exec { 'enable-apachesite':
		command      => 'sudo a2ensite 000-default.conf',
		notify       => Service['apache'],
		path         => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
		require      => [File['config_file'], File['culturely']],
		#refreshonly => true,
	}
}