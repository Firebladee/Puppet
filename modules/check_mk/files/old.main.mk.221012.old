##############################################################################
# This file is mananged by puppet.  Do NOT edit on the server, your changes  #
# will be blown away on the next puppet run.                                 #
##############################################################################

# Put your host names here
# all_hosts = [ 'localhost' ]
define_hostgroups = True
generate_hostconf = True
aggregate_check_mk = True

all_hosts = [ ]

check_parameters = [

( {"levels":(90, 95)}, [ "transoralegeb01" ], [ "fs_/u02" ] ),

]

filesystem_default_levels = {
	"trend_perc" : (20,30),
	"trend_timeleft" : (48,24),
}

extra_host_conf['alias'] = [
        ( 'Puppet server', ['puppet'], ),
]

