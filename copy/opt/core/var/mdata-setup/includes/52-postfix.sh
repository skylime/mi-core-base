#!/bin/bash
# Configure postifx smarthost

POSTFIX_CONF='/opt/local/etc/postfix/'

if mdata-get mail_smarthost 1>/dev/null 2>&1; then
	SMART_HOST=$(mdata-get mail_smarthost)
	/opt/local/bin/sed -i "s:SMART_HOST:${SMART_HOST}:g" \
		${POSTFIX_CONF}main.cf

	# postfix authentication
	if mdata-get mail_auth_user 1>/dev/null 2>&1 && \
	   mdata-get mail_auth_pass 1>/dev/null 2>&1; then
		sed -i "s:smtp_sasl_auth_enable.*:smtp_sasl_auth_enable = yes:g" \
			${POSTFIX_CONF}main.cf
		echo "${SMART_HOST} $(mdata-get mail_auth_user):$(mdata-get mail_auth_pass)" \
			> ${POSTFIX_CONF}relay_passwords
		postmap hash:${POSTFIX_CONF}relay_passwords
	else
		sed -i "s:smtp_sasl_auth_enable.*:smtp_sasl_auth_enable = no:g" \
			${POSTFIX_CONF}main.cf
	fi

	# postalias for root emails
	if mdata-get mail_adminaddr 1>/dev/null 2>&1; then
		(
			cat ${POSTFIX_CONF}aliases | grep -v ^root;
			echo "root: $(mdata-get mail_adminaddr)"
		) > ${POSTFIX_CONF}aliases
	fi
fi
