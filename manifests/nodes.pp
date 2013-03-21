node "puppettest" {

	class { "puppetdb":
		listen_address	=> "0.0.0.0"
	}
}
