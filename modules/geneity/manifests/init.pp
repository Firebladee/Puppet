# /etc/puppet/modules/geneity/manifests

# This module at the moment is just to add an auto log delete system.

class geneity {

	file { "/etc/cron.hourly/geneity_log_remove.sh":
		source => "puppet:///geneity/log_remove.sh",
	}
	file { "/etc/cron.hourly/feedfiles_remove.sh":
                source => "puppet:///geneity/feedfiles_remove.sh",
        }
}
