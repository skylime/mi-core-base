#!/usr/bin/env bash
# Support to add users to the wheel group and allow root permissions. By
# default this should be avoided for the admin user to provide better security.

if SUDO_WHEEL_MEMBERS=$(mdata-get sudo_wheel_members >/dev/null 2>&1); then
	# Create wheel group and ignore if it already exists
	groupadd -g 100 wheel || true
	# Add entry for wheel group
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /opt/local/etc/sudoers.d/wheel
	# Parse space sperated list and add users to wheel group

	for member in ${SUDO_WHEEL_MEMBERS}; do
		# Verify if user exists
		if id ${member} >/dev/null 2>&1; then
			usermod -G wheel,$(groups ${member} | tr ' ' ',') ${member}
		fi
	done
fi
