##############################################################################
# This file is mananged by puppet.  Do NOT edit on the server, your changes  #
# will be blown away on the next puppet run.                                 #
##############################################################################

extra_nagios_conf += """

# timeperiods.cfg

define timeperiod{
        timeperiod_name 24x7
        alias		24 Hours A Day, 7 Days A Week
        sunday		00:00-24:00
        monday		00:00-24:00
        tuesday		00:00-24:00
        wednesday       00:00-24:00
        thursday        00:00-24:00
        friday		00:00-24:00
        saturday        00:00-24:00
}

# Here is a slightly friendlier period during work hours
define timeperiod{
        timeperiod_name workhours
        alias		Standard Work Hours
        monday		09:00-17:00
        tuesday		09:00-17:00
        wednesday       09:00-17:00
        thursday        09:00-17:00
        friday		09:00-17:00
}

define contact{
        contact_name			root
        alias                      	Root
        service_notification_period     24x7
        host_notification_period        24x7
        service_notification_options    w,u,c,r
        host_notification_options       d,r
        service_notification_commands   notify-service-by-email
        host_notification_commands      notify-host-by-email
        email                      	root@localhost
}

###############################################################################
# CONTACT GROUPS

define contactgroup{
        contactgroup_name	admins
        alias              	Nagios Administrators
        members          	root
}


"""

extra_host_conf['notification_period'] = [
        ( "workhours",  [ '!PROD' ],    ALL_HOSTS ),
        ( "24x7",       [ 'PROD' ],     ALL_HOSTS ),
]

