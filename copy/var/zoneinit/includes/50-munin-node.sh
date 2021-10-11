#!/usr/bin/env bash
# Configure munin-node allowed connections

MUNIN_DIR='/opt/local/etc/munin'
MUNIN_CONF=${MUNIN_DIR}'/munin-node.conf'

cp ${MUNIN_CONF}.tpl ${MUNIN_CONF}
if mdata-get munin_master_allow 1>/dev/null 2>&1; then
	echo "# mdata-get munin_master_allow" >> ${MUNIN_CONF}
	for allow in $(mdata-get munin_master_allow); do
		echo "allow ^${allow//\./\\.}$" >> ${MUNIN_CONF}
	done
fi
if MUNIN_TLS=$(mdata-get munin_tls 2>/dev/null); then
	(
		umask 0027
		mkdir -p ${MUNIN_DIR}/ssl
		echo ${MUNIN_TLS} > ${MUNIN_DIR}/ssl/munin.pem
		openssl pkey -in "${MUNIN_DIR}/ssl/munin.pem" -out "${MUNIN_DIR}/ssl/munin.key"
		openssl crl2pkcs7 -nocrl -certfile "${MUNIN_DIR}/ssl/munin.pem" | \
			openssl pkcs7 -print_certs -out "${MUNIN_DIR}/ssl/munin.crt"
	)
	cat <<-EOF > ${MUNIN_CONF}
	# mdata-get munin_tls (certificate)
	tls paranoid
	tls_verify_certificate yes
	tls_private_key ${MUNIN_DIR}/ssl/munin.key
	tls_certificate ${MUNIN_DIR}/ssl/munin.crt
	tls_ca_certificate ${MUNIN_DIR}/ssl/ca.crt
	tls_verify_depth 5
	EOF
fi

# Enable munin service
/usr/sbin/svcadm enable svc:/pkgsrc/munin-node:default
