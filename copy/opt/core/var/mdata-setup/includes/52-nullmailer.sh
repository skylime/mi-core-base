#!/bin/bash
if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	echo "$(hostname)" > /opt/local/etc/nullmailer/defaulthost

	if mdata-get mail_adminaddr 1>/dev/null 2>&1; then
		mdata-get mail_adminaddr > /opt/local/etc/nullmailer/adminaddr
	fi
	AUTH=""
	if mdata-get mail_auth_user 1>/dev/null 2>&1 && 
	   mdata-get mail_auth_pass 1>/dev/null 2>&1; then
		AUTH="--user=$(mdata-get mail_auth_user) --pass=$(mdata-get mail_auth_pass)"
	fi
	echo "$(mdata-get mail_smarthost) smtp --ssl $AUTH" > /opt/local/etc/nullmailer/remotes
fi
