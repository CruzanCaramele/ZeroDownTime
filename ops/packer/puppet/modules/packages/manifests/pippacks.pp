# Class: packages::pippacks
#
#
class packages::pippacks {
	

	$pipinstalls = [
		"Flask-SQLAlchemy",
		"sqlalchemy-utils",
		"bleach",
		"oauth2client",
		"requests",
		"httplib2",
		"itsdangerous",
		"flask-httpauth",
		"Werkzeug",
		"Flask-WTF",
		"WTForms",
		"arrow",
		"flask-login",
		"virtualenv",
		"flask-bcrypt",
		"Glances",
		"PySensors",
		"passlib"
	]

	package { $pipinstalls:
		ensure   => installed,
		provider => pip,
		require  => [Package[$packages::installs], Package[$packages::devpacks::installations]],
	}

}