#!/usr/bin/env bash
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
	echo "MANAGE_ZFS=YES" >> /etc/default/useradd

	if ! zfs list -H -o mountpoint ${DDS}/home/admin 2>/dev/null | grep "/home/admin"; then
		if [ -d "/home/admin" ]; then
			rm -r /home/admin
		fi

		zfs create -p ${DDS}/home/admin
	else
		zfs set mountpoint=none ${DDS}/home/admin
	fi

	if ! zfs get mountpoint -o source ${DDS}/home 2>/dev/null | grep "local"; then
		zfs set mountpoint=/home ${DDS}/home
	fi

	zfs set mountpoint=/home/admin ${DDS}/home/admin
	install_skel
else
	mkdir -p /home/admin
	install_skel
fi
