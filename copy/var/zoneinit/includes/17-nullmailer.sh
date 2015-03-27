if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	echo XXX add smf manifest
	#/usr/sbin/svcadm enable svc:/pkgsrc/nullmailer:default
fi