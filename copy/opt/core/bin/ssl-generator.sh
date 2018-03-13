#!/usr/bin/env bash
# This script try to generate the ssl certificate which is needed based
# on the parameter provided. It support mdata information or let's encrypt
# and restart a service is needed

ssl() {
	local ssl_home=${1}
	local mdata_var=${2}
	local filename=${3}
	local service=${@:4}

	mkdir -p "${ssl_home}"

	if mdata-get ${mdata_var} 1>/dev/null 2>&1; then
		(
		umask 0027
		mdata-get ${mdata_var} > "${ssl_home}/${filename}.pem"
		# Split files for ${filename} usage
		openssl pkey -in "${ssl_home}/${filename}.pem" -out "${ssl_home}/${filename}.key"
		openssl crl2pkcs7 -nocrl -certfile "${ssl_home}/${filename}.pem" | \
			openssl pkcs7 -print_certs -out "${ssl_home}/${filename}.crt"
		)
	else
		# Try to generate let's encrypt ssl certificate for the hostname
		if /opt/core/bin/ssl-letsencrypt.sh 1>/dev/null; then
			local le_home='/opt/local/etc/letsencrypt/'
			local le_live="${le_home}live/$(hostname)/"
			# Workaround to copy correct files for ssl_home
			(
			umask 0027
			cat ${le_live}fullchain.pem > ${ssl_home}/${filename}.crt
			cat ${le_live}privkey.pem   > ${ssl_home}/${filename}.key
			)
			# Update renew-hook.sh
			grep -q '^#!/usr/bin/env bash' ${le_home}renew-hook.sh || echo '#!/usr/bin/env bash' > ${le_home}renew-hook.sh
			echo "cat ${le_live}fullchain.pem > ${ssl_home}/${filename}.crt" >> ${le_home}renew-hook.sh
			echo "cat ${le_live}privkey.pem   > ${ssl_home}/${filename}.key" >> ${le_home}renew-hook.sh
			[[ ! -z ${service} ]] && \
				echo "svcadm restart ${service}" >> ${le_home}renew-hook.sh
		else
			# Fallback to selfsigned ssl certificates
			/opt/core/bin/ssl-selfsigned.sh -d ${ssl_home} -f ${filename}
		fi
	fi
}

if [[ ${#} -lt 3 ]]; then
	echo "${0} ssl_home mdata_var filename [services ...]"
	echo 
	echo "PARAMETER:"
	echo "  ssl_home:  Full path to filename"
	echo "  mdata_var: Metadata variable for lookup if exists"
	echo "  filename:  SSL certificate and key filename"
	echo "  service:   SMF services name"
	echo
	echo "EXAMPLE:"
	echo "  ${0} /opt/local/etc/exim/ssl submission_ssl exim svc:/pkgsrc/exim:default"
	exit 1
fi

ssl ${1} ${2} ${3} ${@:4}
