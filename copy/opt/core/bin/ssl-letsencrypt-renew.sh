#!/usr/bin/env bash
# Helper script to renew all SSL Let's Encrypt SSL certificates easily

[ "${1^}" = "--debug" ] || quiet='--quiet'

/opt/local/bin/certbot renew \
	--text \
	--non-interactive \
	${quiet}
