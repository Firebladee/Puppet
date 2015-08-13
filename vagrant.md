
[*How to use the vagrant system.*]

This will give you a puppet master and two clients so you can test you puppet code

[*How*]

vagrant up

Will bring up the puppet master and both clients.  You will then need to go onto each client and sign certificates.  But other than that, 'puppet agent --test' works as normal on each client.

[*TODO*]
Autosign certificates
Fix puppetmaster start up so 'vagrant provision' works correctly. - Done 13/8/15
Intergrate the vagrant module into hiera and the puppet module.  Gole is to have this built all from hiera with out needing a vagrant module.
