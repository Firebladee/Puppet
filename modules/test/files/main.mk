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

host_groups = [
        ( 'fred', [ 'fred' ], ALL_HOSTS ),
        ( 'mark', [ 'mark' ], ALL_HOSTS ),
]

extra_host_conf['alias'] = [
        ( 'Puppet server', ['puppet'], ),
]
