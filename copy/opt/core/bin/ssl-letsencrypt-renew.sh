#!/usr/bin/env bash
# Helper script to renew all SSL Let's Encrypt SSL certificates easily

[ "${1^}" = "--debug" ] || quiet='--quiet'

/opt/local/bin/certbot renew \
	--text \
	--non-interactive \
	${quiet} \
	--pre-hook "/opt/local/etc/letsencrypt/pre-hook.sh" \
	--post-hook "/opt/local/etc/letsencrypt/post-hook.sh" \
	--renew-hook "/opt/local/etc/letsencrypt/renew-hook.sh"
