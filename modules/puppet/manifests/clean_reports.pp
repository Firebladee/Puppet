# /etc/puppet/modules/puppet/manifests/clean_reports.pp

class puppet::clean_reports {
	cron { 'puppet clean reports':
		command => 'cd /var/lib/puppet/reports && find . -type f -name \*.yaml -mtime +30 -print0 | xargs -0 -n50 /bin/rm -f',
		user    => root,
		hour    => 21,
		minute  => 22,
		weekday => 0,
	}
}
