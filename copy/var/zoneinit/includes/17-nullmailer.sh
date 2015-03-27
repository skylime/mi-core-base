if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	/usr/sbin/svcadm enable svc:/pkgsrc/nullmailer:default
fi
