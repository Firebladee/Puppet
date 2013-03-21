$TTL 500

@       IN      SOA     ns1.internal.londonit.org.      sysadmin.londonmarketing.com. (
                        2012092001	; serial number YYMMDDNN
                        500             ; Refresh
                        500             ; Retry
                        500             ; Expire
                        500             ; Min TTL
			)

                NS      ns1.internal.londonit.org. 
                NS      ns2.internal.londonit.org. 


$ORIGIN internal.hotelmap.com.
decarta-dev	IN	A	10.3.50.10
