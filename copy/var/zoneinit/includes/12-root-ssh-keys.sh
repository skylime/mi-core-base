#!/usr/bin/env bash
# Configure ssh public and private key for root user in mdata variable

key_types="rsa ed25519"

for key_type in $key_types; do
	if mdata-get "root_ssh_${key_type}" 1>/dev/null 2>&1; then
		mkdir -p /root/.ssh
		echo "# This file is managed by mdata-get root_ssh_${key_type}" \
			> "/root/.ssh/id_${key_type}"
		mdata-get "root_ssh_${key_type}" >> "/root/.ssh/id_${key_type}"

		# Mostly not required but we only support it with privat key
		if mdata-get "root_ssh_${key_type}.pub" 1>/dev/null 2>&1; then
			echo "# This file is managed by mdata-get root_ssh_${key_type}.pub" \
				> "/root/.ssh/id_${key_type}.pub"
			mdata-get "root_ssh_${key_type}.pub" >> "/root/.ssh/id_${key_type}.pub"
		fi

		# Set correct permissions
		chmod 700 /root/.ssh
		chmod 600 "/root/.ssh/id_${key_type}"{,.pub}
	fi
done
