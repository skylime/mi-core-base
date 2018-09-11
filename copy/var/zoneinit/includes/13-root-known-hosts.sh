#!/bin/bash
# Configure known_hosts for root user in mdata variable

if mdata-get root_known_hosts 1>/dev/null 2>&1; then
	mkdir -p /root/.ssh
	echo "# This file is managed by mdata-get root_known_hosts" \
		> /root/.ssh/known_hosts
	mdata-get root_known_hosts >> /root/.ssh/known_hosts
fi
