#!/usr/bin/env bash
# This script will generate a self signed ssl certificate for temporary
# usage and for development environment. It's moslty used if not ssl
# certificate is provided via mdata.

# Parameter should be only a folder
DESTINATION=${1}
# Parameter isn't required and could be a different hostname
HOSTNAME=${2-$(hostname)}

# Be sure parameter DESTINATION is set
if (( ${#} < 1 )); then
	echo "${0} <DESTINATION> [HOSTNAME]"
	exit 1
fi

# Verify if folder exists
if [[ ! -d "$DESTINATION" ]]; then
	echo "Error: The ${DESTINATION} doesn't exists, please create!"
	exit 2
fi

# Generate key and csr via OpenSSL
openssl req -newkey rsa:2048 -keyout ${DESTINATION}/server.key \
            -out ${DESTINATION}/server.csr -nodes \
            -subj "/C=DE/L=Raindbow City/O=Aperture Science/OU=Please use valid ssl certificate/CN=${HOSTNAME}"

# Generate self signed ssl certificate from csr via OpenSSL
openssl x509 -in ${DESTINATION}/server.csr -out ${DESTINATION}/server.crt -req \
             -signkey ${DESTINATION}/server.key -days 128

# Create one PEM file which contains certificate and key
cat ${DESTINATION}/server.crt ${DESTINATION}/server.key > ${DESTINATION}/server.pem
