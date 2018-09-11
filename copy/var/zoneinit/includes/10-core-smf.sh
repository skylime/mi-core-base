# This script load all SMF manifests from /opt/core/lib/svc/manifest

CORE_SVC_DIR='/opt/core/lib/svc/manifest/'

for xml in ${CORE_SVC_DIR}*; do
	svccfg import ${xml}
done
