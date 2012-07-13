# /etc/puppet/modules/check_mk/manifests/package.pp

# usage
# $check_mk_package = "fred.mkp"
# include check_mk::package::server # on the check_mk server
# include check_mk::package::agent  # on the agent machines

#class check_mk::package::server {

#	$omd_site_home  = "/opt/omd/sites/$omd_site"
#       $check_mk_location = "$omd_site_home/etc/check_mk"

#	define check_mk_pac_ser {
#		file {
#		}
#		exec { "


