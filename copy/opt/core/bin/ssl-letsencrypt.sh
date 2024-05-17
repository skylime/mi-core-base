#!/usr/bin/env bash
# This script will generate a let's encrypt ssl certificate if possible.
# It's a simple wrapper script for the official certbot client, because
# we maybe need the webserver feature to receive a validation.

set -e

# Defaults
CN=$(hostname)
EMAIL=$(mdata-get mail_adminaddr 2> /dev/null || echo '--register-unsafely-without-email')

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
EMAIL='--register-unsafely-without-email'
if [[ ${EMAIL} =~ ".*@.*" ]]; then
    EMAIL="--email ${EMAIL}"
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

# Restore account if mdata exists. As certbot handle account data
# ugly in the file system we need to do that the same way.
LE_DIR='/opt/local/etc/letsencrypt/accounts/'

if cd "${LE_DIR}"*/*/* > /dev/null 2>&1; then
    continue
elif LE_ACCOUNT_SERVER=$(mdata-get le_account_server 2> /dev/null) \
    && LE_ACCOUNT_HASH=$(mdata-get le_account_hash 2> /dev/null) \
    && LE_ACCOUNT_META=$(mdata-get le_account_meta 2> /dev/null) \
    && LE_ACCOUNT_PRIVATE_KEY=$(mdata-get le_account_private_key) \
    && LE_ACCOUNT_REGR=$(mdata-get le_account_regr 2> /dev/null); then

    # Create folder and files required to an account
    LE_ACCOUNT_DIR="${LE_DIR}/${LE_ACCOUNT_SERVER}/directory/${LE_ACCOUNT_HASH}"
    (
        umask 077
        mkdir -p "${LE_ACCOUNT_DIR}"
    )
    (
        umask 277
        echo "${LE_ACCOUNT_PRIVATE_KEY}" > "${LE_ACCOUNT_DIR}/private_key.json"
    )
    echo "${LE_ACCOUNT_META}" > "${LE_ACCOUNT_DIR}/meta.json"
    echo "${LE_ACCOUNT_REGR}" > "${LE_ACCOUNT_DIR}/regr.json"
elif certbot register --agree-tos "${EMAIL}" 2> /dev/null; then

    # Store LE account meta data information
    le_account=$(cd "${LE_DIR}" && echo */*/*)
    mdata-put le_account_server "${le_account%%/*}"
    mdata-put le_account_hash "${le_account##*/}"
    mdata-put le_account_meta < "${LE_DIR}/${le_account}/meta.json"
    mdata-put le_account_private_key < "${LE_DIR}/${le_account}/private_key.json"
    mdata-put le_account_regr < "${LE_DIR}/${le_account}/regr.json"
fi

# Run initial certbot command to create account and certificate
if ! certbot certonly \
    "${BOT_ARGS}" \
    --quiet \
    --text \
    --non-interactive \
    --domains "${CN}"; then
    # Exit on error and ignore crons
    exit 1
fi

# Create cronjob to automatically check or renew the certificate two
# times a day
CRON='0 0,12 * * * /opt/core/bin/ssl-letsencrypt-renew.sh'
(
    crontab -l 2> /dev/null || true
    echo "$CRON"
) | sort | uniq | crontab
