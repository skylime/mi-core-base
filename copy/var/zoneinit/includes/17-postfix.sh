# Enable postfix only if you have a valid config and no other smtpd
# is installed

if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	/usr/sbin/svcadm enable svc:/pkgsrc/postfix:default
fi
