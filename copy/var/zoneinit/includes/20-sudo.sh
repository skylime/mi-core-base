#!/usr/bin/env bash
# Support to add users to the sysadmin group and allow root permissions. By
# default this should be avoided for the admin user to provide better security.

if SUDO_SYSADMIN_MEMBERS=$(mdata-get sudo_sysadmin_members >/dev/null 2>&1); then
	# Add entry for sysadmin group
	echo '%sysadmin ALL=(ALL) NOPASSWD: ALL' > /opt/local/etc/sudoers.d/sysadmin
	chmod 440 /opt/local/etc/sudoers.d/sysadmin
	# Parse space sperated list and add users to sysadmin group
	for member in ${SUDO_SYSADMIN_MEMBERS}; do
		# Verify if user exists
		if id ${member} >/dev/null 2>&1; then
			usermod -G sysadmin,$(groups ${member} | tr ' ' ',') ${member}
		fi
	done
fi
