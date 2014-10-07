#!/bin/bash
# Configure ssh public and private key for root user in mdata variable

if mdata-get root_ssh_rsa 1>/dev/null 2>&1; then
	mkdir -p /root/.ssh
	echo "# This file is managed by mdata-get root_ssh_rsa" \
		> /root/.ssh/id_rsa
	mdata-get root_ssh_rsa >> /root/.ssh/id_rsa

	# Mostly not required but we only support it with privat key
	if mdata-get root_ssh_rsa_pub 1>/dev/null 2>&1; then
		echo "# This file is managed by mdata-get root_ssh_rsa_pub" \
			> /root/.ssh/id_rsa.pub
		mdata-get root_ssh_rsa_pub >> /root/.ssh/id_rsa.pub
	fi

	# Set correct permissions
	chmod 700 /root/.ssh
	chmod 600 /root/.ssh/id_rsa*
fi
