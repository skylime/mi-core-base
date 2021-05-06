#!/usr/bin/env bash
# This script load all SMF manifests from /opt/core/lib/svc/manifest

CORE_SVC_DIR='/opt/core/lib/svc/manifest/'

for xml in ${CORE_SVC_DIR}*; do
	svccfg import ${xml}
done

# Postinit is required to run also on re-provision and images which
# are derived from the core-base image. For that reason it's required
# to set postinit to false.
svccfg -s postinit 'setprop application/done = false'
svcadm refresh postinit
