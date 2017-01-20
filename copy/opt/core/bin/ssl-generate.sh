#!/usr/bin/env bash
# This script will generate a self signed ssl certificate for temporary
# usage and for development environment. It's moslty used if not ssl
# certificate is provided via mdata.

# Defaults
CN=$(hostname)
PREFIX='server'

# Help function
function help() {
	echo "${0} -d <DESTINATION> [-c common name] [-p prefix]"
	exit 1
}

# Option parameters
if (( ${#} < 1 )); then help; fi

while getopts ":d:c:p:" opt; do
	case "${opt}" in
		d) DESTINATION=${OPTARG} ;;
		c) CN=${OPTARG} ;;
		p) PREFIX=${OPTARG} ;;
		*) help ;;
	esac
done

# Verify if folder exists
if [[ ! -d "$DESTINATION" ]]; then
	echo "Error: The ${DESTINATION} doesn't exists, please create!"
	exit 2
fi

# Generate key and csr via OpenSSL
openssl req -newkey rsa:2048 -keyout ${DESTINATION}/${prefix}.key \
            -out ${DESTINATION}/${prefix}.csr -nodes \
            -subj "/C=DE/L=Raindbow City/O=Aperture Science/OU=Please use valid ssl certificate/CN=${CN}"

# Generate self signed ssl certificate from csr via OpenSSL
openssl x509 -in ${DESTINATION}/${prefix}.csr -out ${DESTINATION}/${prefix}.crt -req \
             -signkey ${DESTINATION}/${prefix}.key -days 128

# Create one PEM file which contains certificate and key
cat ${DESTINATION}/${prefix}.crt ${DESTINATION}/${prefix}.key > ${DESTINATION}/${prefix}.pem
