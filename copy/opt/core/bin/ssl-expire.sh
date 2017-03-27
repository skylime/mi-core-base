#!/usr/bin/env bash
# Thomas Merkel <tm@core.io>
# This script could run as cron to check all system certificates. It provides the option
# to ignore files and folders, especially some Let's Encrypt account pem files.

# PATH to have gnutools installed
PATH=/opt/local/bin:${PATH}

# Default location to look for certificates (*.pem, *.crt)
crt_locations=${crt_locations-'/opt/local/etc'}

# Ignore some system CAs and special files which are no certificate files
crt_ignores="mozilla-rootcert-.* privkey.* .*-certbot.pem fullchain.pem chain.pem"

# Ignore Let's Encrypt archive folder because we only check live files
crt_locations_ignores="/opt/local/etc/letsencrypt/archive"

# Now
today_unixtime=$(date +%s)

# Warning trigger
trigger_unixtime=$(date +%s -d "+14 days")

# Lookup
for location in ${crt_locations}; do
	[ ! -d "${location}" ] && continue
	crts=$(find -L ${location} -type f -iname "*.pem" -o -iname "*.crt")

	# Loop through all *.pem and *.crt files
	for crt in ${crts}; do
		# Ignore certs and ignore locations
		for crt_ignore in ${crt_ignores}; do
			[[ $(basename ${crt}) =~ ${crt_ignore} ]] && continue 2
		done
		for crt_locations_ignore in ${crt_locations_ignores}; do
			[[ $(dirname ${crt}) =~ ${crt_locations_ignore} ]] && continue 2
		done

		# OpenSSL receive information from certificate file
		x509=$(openssl x509 -in ${crt} -noout -nameopt RFC2253 -subject -enddate -hash)
		# Parse certificate to receive CommonName
		x509_subject=$(echo ${x509} | gsed 's/.*CN=\([^\ |,]*\).*/\1/')
		# Receive expire unixtime
		expire_unixtime=$(date --date="$(echo ${x509} | gsed 's/.*notAfter=\([^,]*\)\ .*/\1/')" +%s)
		# Receive expire datetime
		expire_datetime=$(date +"%Y-%m-%d" -d "@${expire_unixtime}")

		# Expired
		if [ ${today_unixtime} -gt ${expire_unixtime} ]; then
			critical[${#critical[*]}]="${expire_datetime}: ${subject} (${crt})"
		# Expire during trigger unixtime
		elif [[ ${expire_unixtime} -lt ${trigger_unixtime} && ${expire_unixtime} -gt ${today_unixtime} ]]; then
			warning[${#warning[*]}]="${expire_datetime}: ${subject} (${crt})"
		fi
	done
done

# Output
if [[ "${critical}" ]]; then
	echo "EXPIRED: "
	(for c in "${critical[@]}"; do
		echo " ${c}"
	done) | sort -M -k 2
fi

if [[ "${warning}" ]]; then
	echo "EXPIRE SOON: "
	(for w in "${warning[@]}"; do
		echo " ${w}"
	done) | sort -M -k 2
fi
