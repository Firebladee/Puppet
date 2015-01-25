
[*How to use the vagrant system.*]

This will give you a puppet master and two clients so you can test you puppet code

[*How*]

vagrant up

Wait for the pupet box to fail.

vagrant ssh puppet
sudo -s
yum remove puppetdb
rm -rf /etc/puppetdb

Exit the puppet vm and then
puppet provision puppet

This will get the puppet master to work

vagrant up

Will bring up both clients.  You will then need to go onto each client and sign certificates.  But other than that, 'puppet agent --test' works as normal on each client.

[*TODO*]
Autosign certificates
Fix puppetmaster start up so 'vagrant provision' works correctly.
