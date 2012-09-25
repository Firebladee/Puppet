# /etc/puppet.modules/spacewalk/manifests/init.pp

class spacewalk {

	package {
		gnupg:			ensure => installed;
		pyOpenSSL:		ensure => installed;
		libxm12-python:		ensure => installed;
		dbus-python:		ensure => installed;
		python-dmidecode:	ensure => installed;
		hal:			ensure => installed;
		rhn-client-tools:	ensure => installed;
		rhn-setup:		ensure => installed;
		rhn-check:		ensure => installed;
		rhnlib:			ensure => installed;
		rhnsd:			ensure => installed;
		yum-rhn-plugin:		ensure => installed;
	}

}
