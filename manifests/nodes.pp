# /etc/puppet/manifests/node.pp

node default {
	$puppet_server = "puppet"
	$nrpe_use_ssl = "no"
	$nrpe_allowed_hosts = "10.55.96.152,10.55.96.156,127.0.0.1"
	$nagios_server = "10.55.96.156"

	include ntp
	include ocs
	include check_mk::check_yum
#	class { "check_mk":
#		install         => "agent",
#		omd_site        => "ALL",
#	}
}

node "omd.coraltest.com" inherits default {
	$yum_extrarepo  = "puppetlabs"
#	$check_mk_parent = "172.18.145.11"
	$omd_site	= ["DEV5", "DEV1", "DEV2", "DEV3", "DEV4", "ALL"]

	include yum
#	include check_mk::server
#	include check_mk::agent
#	include check_mk::parents
#	include check_mk::package::puppet::server 
#	include check_mk::package::puppet::agent

#	class { "splunk":
#		install         => "forwarder",
#		install_source  => "http://10.55.96.156/splunk-4.3-115073-linux-2.6-x86_64.rpm",
#		forward_server  => "10.55.0.91:9997",
#		admin_password  => "Password01",
#		monitor_path    => "/var/log"
#	}

	include omd
	include omd::site::add
	include sudo
	include ntp

	class { "check_mk":
		install		=> "server",
		omd_site	=> ["DEV5", "DEV1", "DEV2", "DEV3", "DEV4", "ALL"],
		parents		=> "172.18.145.11",
		check_mk_tags	=> "Management"
	}
}

node "wkse10m1xomd01.wok1.egalacoral.com" inherits default {
	$yum_extrarepo  = "puppetlabs"
	$omd_site       = ["DEV5", "DEV1", "DEV2", "DEV3", "DEV4", "ALL"]

	include yum
	include omd
	include omd::site::add
	class { "check_mk":
		install         => "server",
		omd_site        => ["DEV5", "DEV1", "DEV2", "DEV3", "DEV4", "ALL"],
		check_mk_tags   => "Management"
	}
}

node "puppet.coraltest.com" inherits default {
	$yum_extrarepo  = "puppetlabs"

        include yum
	class { "check_mk":
                install         => "agent",
                omd_site	=> "ALL",
		parents		=> "172.18.145.11",
		check_mk_tags	=> "Management"
        }
	include check_mk::check_yum
	include ntp
#	class { 'puppetdashboard': }
	include puppet::clean_reports
}

node "gucedapp02.gue1.egalacoral.com", "gucedapp03.gue1.egalacoral.com" inherits default {
	$yum_extrarepo	= ["puppetlabs", "spacewalk-client"]

	include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV1"],
		check_mk_tags	=> "DEV1",
        }
#	include check_mk::package::puppet::agent
	include geneity
	include ntp
	include puppet
	include hosts::allow
}

node "gucedapp01.gue1.egalacoral.com" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV1"],
		check_mk_tags	=> "DEV1",
        }
#	include check_mk::package::puppet::agent
        include hosts::allow
        include geneity
        include ntp
	include puppet
}

node "gucedapp06.gue1.egalacoral.com", "gucedapp08.gue1.egalacoral.com", "gucedapp07.gue1.egalacoral.com" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

	include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV2"],
		check_mk_tags	=> "DEV2",
        }
#	include check_mk::package::puppet::agent
	include hosts::allow
	include geneity
	include ntp
	include puppet
}

node "yieldobi01.wok1.egalacoral.com", "test01.wok1.egalacoral.com", "test02.wok1.egalacoral.com" inherits default {
	$yum_extrarepo	= "puppetlabs"

	include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => "ALL",
		check_mk_tags	=> "yield"
        }
#	include check_mk::package::puppet::agent
	include ntp
	include puppet
}

node "puppet-test.coraltest.com" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]
	$omd_site       = "ALL"
#	$check_mk_tags	= "fred"

	include yum
#	include check_mk::agent
#	check_mk_agent { "ALL":
#		check_mk_tags	=> "dashboard"
#	}
#	include check_mk::package::puppet::agent
	include ntp

	include hosts::allow
#	hosts::allow::hostsallow { "hostsallow":
#		nrpe	=> ["127.0.0.1", "10.0.0.1"]
#	}

	class { 'puppetdashboard':
		port	=> "80"
	 }

	include git
#	include test::agent_test
#	check_mk_agent_test { "ALL":
#		check_mk_tags => ["fred", "mark"]
#	}
	class { "check_mk":
		install		=> "agent",
		omd_site	=> "ALL",
		parents		=> "172.18.145.11",
		check_mk_tags	=> "mark",
		check_mk_alias	=> "Testing server for puppet"
	}
		
#	include spacewalk

#	include augeas-extra

	include sudo

	include ocs
}

node "transoralegeb01" inherits default {
	$yum_extrarepo  = "puppetlabs"

	include ntp
	include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV5"],
		check_mk_tags	=> "DEV5"
        }
	include oracle
	include puppet
}

node "trans1dev2app01.dev.coral.co.uk", "transapplegeb01" inherits default {
	$yum_extrarepo  = "puppetlabs"

	include ntp
	include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV5"],
		check_mk_tags	=> "DEV5"
        }
	include geneity
	include puppet
}

node "bkgl15d1xssbt01", "bkgl15d1xssbt02" inherits default {
	$yum_extrarepo  = "puppetlabs"

        include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV5"],
		check_mk_tags	=> ["DEV5", "SSBT"]
        }
	include sudo
	include geneity
	include puppet
}

node "gucedora05", "gucedora06" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

        include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV1"],
		check_mk_tags	=> "DEV1"
        }
        include hosts::allow
	include puppet
}

node "gucedora08", "gucedora09" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

        include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV2"],
		check_mk_tags	=> "DEV2"
        }
        include hosts::allow
	include puppet
}

node "gucedora12" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

	include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => ["ALL", "DEV3"],
		check_mk_tags	=> "DEV3"
        }
	include hosts::allow
	include puppet
}

node "gucerapp01", "gucerapp02", "gucerapp03", "gucedapp09" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

        include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => "ALL",
        }
	include hosts::allow
	include geneity
	include puppet
}

node "gucedora15", "gucedora16", "guceddok01", "gucerdok01" ,"wkse14t1xora01" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

        include ntp
        include yum
	class { "check_mk":
                install         => "agent",
                omd_site        => "ALL",
	}
	include hosts::allow
	include puppet
}

node "wkse14t1xssbt01" inherits default {
	$yum_extrarepo  = ["puppetlabs", "spacewalk-client"]

	include ntp
	include yum
	class { "check_mk":
		install		=> "agent",
		omd_site	=> "ALL",
		check_mk_tags	=> ["GEN", "HTTP", "REG", "SSH"],
		check_mk_alias	=> "Genbet Regression - SSBT App 1",
	}
	include puppet
	include hosts::allow
}

node "bkglrapp04", "bkglrapp05" inherits default {
	$yum_extrarepo  = "puppetlabs"

	include ntp
	include yum
	class { "check_mk":
		install		=> "agent",
		omd_site	=> "ALL",
	}
	include puppet
}

node "wkse15dxora01" inherits default {
	$yum_extrarepo  = "puppetlabs"

        include ntp
        include yum
        class { "check_mk":
                install         => "agent",
                omd_site        => "ALL",
        }
        include puppet
	include oracle
}

