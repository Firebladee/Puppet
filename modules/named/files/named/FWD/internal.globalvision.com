$TTL 500

@       IN      SOA     ns1.internal.londonit.org.      sysadmin.londonmarketing.com. (
                        2012200801	; serial number YYMMDDNN
                        500             ; Refresh
                        500             ; Retry
                        500             ; Expire
                        500             ; Min TTL
			)

                NS      ns1.internal.londonit.org. 
                NS      ns2.internal.londonit.org. 


$ORIGIN internal.globalvision.com.
monitor1		A	10.3.0.4
vm01			A	10.3.0.5
vm02			A	10.3.0.7
vm03			A	10.3.0.12
vm04			A	10.3.0.15
vm05			A	10.3.0.16
vm06			A	10.3.0.18
vcenter			A	10.3.0.150
hotelsearchdev		A	10.3.0.50
restaurantsstage	A	10.3.0.50
hotelsearch		A	10.3.0.40
hotelsearch1		A	10.3.5.1
hotelsearch2		A	10.3.5.2
hotelsearch3		A	10.3.5.3
hotelsearch4		A	10.3.5.4
hotelsearch5		A	10.3.5.5
hotelsearch6		A	10.3.5.6
hotelsearch7		A	10.3.5.7
hotelsearch8		A	10.3.5.8
hotelsearch9		A	10.3.5.9
hotelsearch10		A	10.3.5.10
restaurants		A	10.3.0.41
log1			A	10.3.1.2

;;OFFICE STUFF
fw01            IN      A       10.0.0.1
gold0            IN      A       10.0.2.3
gold-0           IN      CNAME   gold0
mailbox          IN      A       10.0.2.7
sandbox		 IN     CNAME    mailbox
vishnu		 IN	 A	 10.0.2.14
smithers         IN      A       10.0.2.212
izzard		 IN      A       10.0.2.48
xhost-1		 IN	A	10.0.2.212

; catch alls
*.blender-1	 IN	 CNAME	 blender-1


;
; mail servers
;
primary-1.mail   IN      CNAME   mailbox
secondary-1.mail IN      CNAME   mailbox


;
; development servers
;
dev2            IN      CNAME   dev-default-1 
secure 		 IN	 CNAME   dev-default-1 
dev-default-1	IN      A       10.0.2.205
hotelsearchdev	IN	A	10.0.2.206

;
;  Kerberos Infos
;

_kerberos		TXT	"INTERNAL.GLOBALVISION.COM"
_kerberos._udp		SRV	0 0 88  gold0
_kpasswd._udp		SRV     0 0 464 gold0
_kerberos-adm._udo	SRV	0 0 749 gold0

