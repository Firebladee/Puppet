$TTL 500

@       IN      SOA     ns1.internal.londonit.org.      sysadmin.londonmarketing.com. (
                        2012091001	; serial number YYMMDDNN
                        500             ; Refresh
                        500             ; Retry
                        500             ; Expire
                        500             ; Min TTL
			)

                NS      ns1.internal.londonit.org. 
                NS      ns2.internal.londonit.org. 

ns		 IN	A	10.3.0.10
fai			CNAME	gold-1
primary-1		CNAME	gold-1.live-1.globalvision.com.
primary-1.stage		CNAME	gold-1.live-1.globalvision.com.
secondary-1-1		IN	CNAME	oldstage.live-1.globalvision.com.
gw1		A	10.3.0.1
gw2		A	10.3.0.3
gateway-1		A	10.3.0.3
gateway-2		A	10.3.0.4
gold-1			CNAME	gold1
gold1			A	10.3.0.2
test-1.java		A	10.3.1.22
LI			A	10.3.0.106
livesql			CNAME	sql-1
splunk01		A	10.3.0.14
loghost			CNAME	splunk01
logs			CNAME	gold-1
weblogs			A	192.168.129.254
web-104			A	192.168.129.114
primary-1.mail		CNAME	gold-1
oldstage		A	10.3.0.50
readsql			A	10.3.0.200
test-1			A	10.3.1.11
db2			A	10.3.0.102
db3			A	10.3.0.108
db4			A	10.3.0.104
db7			A	10.3.0.105
db6			A	10.3.0.117
directorycache		A	10.3.0.30
hotelsearch		A	10.3.0.40
$GENERATE 1-255 hotelsearch$.live-1.globalvision.com.	A	10.3.5.$
$GENERATE 1-255 newweb$.live-1.globalvision.com.	A	10.3.6.$
solr1			A	10.3.9.1
solr2			A	10.3.9.2
solr-slave1		A	10.3.9.4
solr-slave2		A	10.3.9.5
cronjobs		A	10.3.0.11
hotelsearchcluster	A	10.3.0.40
solrsearch	IN	A	10.3.9.254
java			A	10.3.0.201
primary-1.resin		A	10.3.1.12
secondary-1-1.resin	A	10.3.1.12
srv-1-10		A	10.3.1.12
srv-1-12		A	10.3.1.12
mail1			A	10.3.0.107
vcenter			A	10.3.0.150
