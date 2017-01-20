#!/usr/bin/env bash
# This script will generate a self signed ssl certificate for temporary
# usage and for development environment. It's moslty used if not ssl
# certificate is provided via mdata.

# Defaults
CN=$(hostname)
FILENAME='server'

# Help function
function help() {
	echo "${0} -d <DESTINATION> [-c common name] [-f filename]"
	exit 1
}

# Option parameters
if (( ${#} < 1 )); then help; fi

while getopts ":d:c:f:" opt; do
	case "${opt}" in
		d) DESTINATION=${OPTARG} ;;
		c) CN=${OPTARG} ;;
		p) FILENAME=${OPTARG} ;;
		*) help ;;
	esac
done

# Verify if folder exists
if [[ ! -d "$DESTINATION" ]]; then
	echo "Error: The ${DESTINATION} doesn't exists, please create!"
	exit 2
fi

# Generate key and csr via OpenSSL
openssl req -newkey rsa:2048 -keyout ${DESTINATION}/${FILENAME}.key \
            -out ${DESTINATION}/${FILENAME}.csr -nodes \
            -subj "/C=DE/L=Raindbow City/O=Aperture Science/OU=Please use valid ssl certificate/CN=${CN}"

# Generate self signed ssl certificate from csr via OpenSSL
openssl x509 -in ${DESTINATION}/${FILENAME}.csr -out ${DESTINATION}/${FILENAME}.crt -req \
             -signkey ${DESTINATION}/${FILENAME}.key -days 128

# Create one PEM file which contains certificate and key
cat ${DESTINATION}/${FILENAME}.crt ${DESTINATION}/${FILENAME}.key > ${DESTINATION}/${FILENAME}.pem
