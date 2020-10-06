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
		hostname=$(hostname)
		# Verify if port 80, if true use let's encrypt with webroot configuration
		local le_args=''
		if ls /proc/ 2>/dev/null | while read id; do pfiles ${id} 2>/dev/null; done \
			| grep -q "[s]ockname: AF_INET.*port: 80"; then
			le_args='-t webroot'
		fi

		# Support Alt-SANs if a special mdata-variable exists which ends
		# with _hostlist
		if mdata-get ${mdata_var}_hostlist 1>/dev/null 2>&1; then
			# Make it comma seperated without spaces
			hostlist=$(mdata-get ${mdata_var}_hostlist | tr -d ' ')
			le_args="${le_args} -d ${hostlist}"
			hostname=$(echo ${hostlist} | awk -F, '{ print $1 }')
		fi

		# Try to generate let's encrypt ssl certificate for the hostname
		if /opt/core/bin/ssl-letsencrypt.sh ${le_args} 1>/dev/null; then
			local le_home='/opt/local/etc/letsencrypt/'
			local le_live="${le_home}live/${hostname}/"
			# Workaround to copy correct files for ssl_home
			(
			umask 0027
			cat ${le_live}fullchain.pem > ${ssl_home}/${filename}.crt
			cat ${le_live}privkey.pem   > ${ssl_home}/${filename}.key
			)
			# Create hooks/renew/${filename}.sh
			echo '#!/usr/bin/env bash'                                       >  ${le_home}/renewal-hooks/deploy/${filename}.sh
			echo "cat ${le_live}fullchain.pem > ${ssl_home}/${filename}.crt" >> ${le_home}/renewal-hooks/deploy/${filename}.sh
			echo "cat ${le_live}privkey.pem   > ${ssl_home}/${filename}.key" >> ${le_home}/renewal-hooks/deploy/${filename}.sh
			[[ ! -z ${service} ]] && \
				echo "svcadm restart ${service}" >> ${le_home}/renewal-hooks/deploy/${filename}.sh
			chmod 750 ${le_home}/renewal-hooks/deploy/${filename}.sh
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
