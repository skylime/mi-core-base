#!/usr/bin/env bash

if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	echo "$(hostname)" > /opt/local/etc/nullmailer/me

	if mdata-get mail_adminaddr 1>/dev/null 2>&1; then
		mdata-get mail_adminaddr > /opt/local/etc/nullmailer/adminaddr
	fi
	AUTH=""
	if mdata-get mail_auth_user 1>/dev/null 2>&1 &&
	   mdata-get mail_auth_pass 1>/dev/null 2>&1; then
		AUTH="--user=$(mdata-get mail_auth_user) --pass=$(mdata-get mail_auth_pass)"
	fi
	echo "$(mdata-get mail_smarthost) smtp --ssl $AUTH" > /opt/local/etc/nullmailer/remotes
	chown nullmail:nullmail /opt/local/etc/nullmailer/remotes
	chmod 0640 /opt/local/etc/nullmailer/remotes

	# Enable nullmailer service
	/usr/sbin/svcadm enable svc:/pkgsrc/nullmailer:default
fi

