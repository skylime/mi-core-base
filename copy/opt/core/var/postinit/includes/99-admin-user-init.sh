#!/usr/bin/env bash
# Run admin user init.sh from home folder if exists. The script should run as
# user who owns it.

if [ -x /home/admin/init.sh ]; then
	( sudo -u admin bash -x /home/admin/init.sh 2>&1 ) |\
		mailx -s "postinit /home/admin/init.sh" root
fi
