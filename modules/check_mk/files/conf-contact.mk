##############################################################################
# This file is mananged by puppet.  Do NOT edit on the server, your changes  #
# will be blown away on the next puppet run.                                 #
##############################################################################

extra_nagios_conf += """

### IF YOU WANT TO CHANGE THE EMAIL ALERT FORMATTING, SEE: /etc/nagios3/command.cfg


##########################################################################
#
#  To add a new user:
#       ** Add the name to the required "Contact Groups" (Normally one divisionalised entry, plus
#               another entry in the generic "LinuxSysAdmins" group)
#       ** Create a new Contact in the "Contact Individuals" section below; easiest to copy someone else's :)
#
#
#####################
#####################
## Contact Groups  ##
#####################
#####################

define contactgroup {
        contactgroup_name               LinuxSysAdmins
        alias                           Operations - Linux Systems Administrators
        members                         Coral Linux
}

#############################################################################

#########################
#########################
## Contact Individuals ##
#########################
#########################

#define contact {
#       contact_name                    Darren Gibbard
#       alias                           Darren Gibbard - Systems Administrator
#       host_notifications_enabled      1
#       service_notifications_enabled   1
#       host_notification_period        24x7
#       service_notification_period     24x7
#       host_notification_options       d,u,r,f,s
#       service_notification_options    w,u,c,r,f,s
#       host_notification_commands      notify-host-by-email
#       service_notification_commands   notify-service-by-email
#       email                           darren.gibbard@galacoral.com
#}

define contact {
        contact_name                    Coral Linux
        alias                           Coral Linux Team Email Address
        host_notifications_enabled      1
        service_notifications_enabled   1
        host_notification_period        24x7
        service_notification_period     24x7
        host_notification_options       d,u,r,f,s
        service_notification_options    w,u,c,r,f,s
        host_notification_commands      notify-host-by-email
        service_notification_commands   notify-service-by-email
#        email                           CoralLinux@galacoral.com
	email                           mark.greenhalgh@galacoral.com
}

####################################################### Shouldn't need to amend past this point.

"""

host_contactgroups = [
  ( "LinuxSysAdmins",                           ALL_HOSTS ),
]
