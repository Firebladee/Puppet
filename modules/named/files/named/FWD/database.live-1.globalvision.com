$TTL 500

@       IN      SOA     ns1.internal.londonit.org.      sysadmin.londonmarketing.com. (
                        2012041201	; serial number YYMMDDNN
                        500             ; Refresh
                        500             ; Retry
                        500             ; Expire
                        500             ; Min TTL
			)

                NS      ns1.internal.londonit.org. 
                NS      ns2.internal.londonit.org. 


$ORIGIN database.live-1.globalvision.com.
backup-1		CNAME	secondary-1-1
primary-1		A	10.3.0.103
primary-2		CNAME	mail1.live-1.globalvision.com.
newprimary-1		A	10.3.0.108
readonly		A	10.3.0.17
secondary-1-1		CNAME	db4.live-1.globalvision.com.
secondary-1-4		CNAME	mail1.live-1.globalvision.com.
secondary-2-1		CNAME	mail1.live-1.globalvision.com.
sql-5			A	10.0.2.191
temporary-1		CNAME	mail1.live-1.globalvision.com.
