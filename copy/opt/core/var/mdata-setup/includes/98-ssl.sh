#!/usr/bin/env bash
# This script try to manage and configure let's encrypt ssl certificates.
# At the moment it's only build to support the hostname which is provided
# by the operating system / zone itself.

if mdata-get letsencrypt 1>/dev/null 2>&1; then
	HOST=$(hostname)
	# This will only work if we could resolve our own hostname
	if host ${HOST} 1>/dev/null 2>&1; then
		# Setup account email address to mail_adminaddr if exists
		if mdata-get mail_adminaddr 1>/dev/null 2>&1; then
			EMAIL="--email $(mdata-get mail_adminaddr)"
		else
			EMAIL='--register-unsafely-without-email'
		fi

		# Run initial certbot command to create account and certificate
		certbot certonly
			--standalone \
			--agree-tos \
			--quiet \
			--text \
			--non-interactive
			${EMAIL} \
			--domains ${HOST}

		# Create cronjob to automatically check or renew the certificate two
		# times a day
		CRON='0 0,12 * * * certbot renew --text --non-interactive --quiet'
		(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
	fi
fi
