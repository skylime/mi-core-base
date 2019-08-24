#!/bin/bash
UUID=$(mdata-get sdc:uuid)
DDS=zones/${UUID}/data

function install_skel() {
	# If first creation is a success copy all data from skel
	cp -r /etc/skel/. /home/admin

	# Update PATH for our personal core utils
	gsed -i 's|^PATH=\(.*\)|PATH=\1:/opt/core/bin|g' /home/admin/.profile

	# Fix permissions for home folder
	chmod 700 /home/admin
	chown -R admin:staff /home/admin
}

if zfs list ${DDS} 1>/dev/null 2>&1; then
	if ! zfs list ${DDS}/home/admin 1>/dev/null 2>&1; then
		# Create delegate dataset for home/admin
		zfs create -p ${DDS}/home/admin

		# Remove the folder as well because of delegate dataset
		rm -r /home/admin

		# Set mount point and fix permissions
		zfs set mountpoint=/home/admin ${DDS}/home/admin

		install_skel
	fi
else
	install_skel
fi
