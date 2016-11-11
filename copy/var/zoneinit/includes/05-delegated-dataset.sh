#!/bin/bash
UUID=$(mdata-get sdc:uuid)
DDS=zones/${UUID}/data

if zfs list ${DDS} 1>/dev/null 2>&1; then
	if zfs create ${DDS}/root 1>/dev/null 2>&1; then
		# Remove the folder as well because of delegate dataset
		rm -r /root

		# Set mount point and fix permissions
		zfs set mountpoint=/root ${DDS}/root

		# If first creation is a success copy all data from skel
		cp -r /etc/skel/. /root
	fi

	# Fix permissions for home folder
	chmod 700 /root
else
	# If first creation is a success copy all data from skel
	cp -r /etc/skel/. /root
fi
