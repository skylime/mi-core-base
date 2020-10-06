#!/usr/bin/env bash
# This script will generate a let's encrypt ssl certificate if possible.
# It's a simple wrapper script for the official certbot client, because
# we maybe need the webserver feature to receive a validation.

# Defaults
CN=$(hostname)
EMAIL=$(mdata-get mail_adminaddr 2>/dev/null)

# Ignore python warnings by default in this script
export PYTHONWARNINGS="ignore"

# Help function
function help() {
	echo "${0} [-c common name] [-m mail address] [-t type]"
	echo
	echo "TYPE:"
	echo "  standalone: Doesn't require any webserver to be running"
	echo "  webroot:    Require webserver to be configured for webroot /var/letsencrypt/acme"
	exit 1
}

# Option parameters
while getopts ":c:m:t:" opt; do
	case "${opt}" in
		c) CN=${OPTARG} ;;
		m) EMAIL=${OPTARG} ;;
		t) TYPE=${OPTARG} ;;
		*) help ;;
	esac
done

# Setup account email address to mail_adminaddr if exists
if [[ ! -z ${EMAIL} ]]; then
	EMAIL="--email ${EMAIL}"
else
	EMAIL='--register-unsafely-without-email'
fi

# Configure default parameters
# Fallback type is always standalone
case ${TYPE} in
	webroot)
		mkdir -p /var/letsencrypt/acme
		BOT_ARGS='--webroot -w /var/letsencrypt/acme'
		;;
	*)
		BOT_ARGS='--standalone'
		;;
esac

# Run initial certbot command to create account and certificate
if ! certbot certonly \
	${BOT_ARGS} \
	--agree-tos \
	--quiet \
	--text \
	--non-interactive \
	${EMAIL} \
	--domains ${CN}; then
	# Exit on error and ignore crons
	exit 1
fi

# Create cronjob to automatically check or renew the certificate two
# times a day
CRON='0 0,12 * * * /opt/core/bin/ssl-letsencrypt-renew.sh'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
