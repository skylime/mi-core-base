#!/usr/bin/env bash
# Configure remote backup server if available and present via mdata variable.
# Modify all existing znapzendzetups. If parts are not available try to provide
# information via /etc/motd.

# Default znapzend zetup plan if not present via mdata
ZNAPZEND_DST_PLAN=$(mdata-get znapzend_dst_plan 2>/dev/null ||\
	echo "7days=>8hours,30days=>1day,1year=>1week,10years=>1month")

# Verify mdata exists
if ZNAPZEND_DST=$(mdata-get znapzend_dst 2>/dev/null); then
	# Verify requirements (root id_rsa, known_hosts)
	[ ! -f /root/.ssh/id_rsa ] && exit 0
	ZNAPZEND_DST_HOST=$(echo "${ZNAPZEND_DST_HOST}" | sed -n 's/\(.*@\)\?\(.*\):.*/\2/p')
	if ! grep -q "${ZNAPZEND_DST_HOST}" /root/.ssh/known_hosts; then
		(return 0 2>/dev/null) && exit 0
		# If not sourced try to receive remote host key
		ssh-keyscan "${ZNAPZEND_DST_HOST}" >> /root/.ssh/known_hosts
		grep -v \# /root/.ssh/known_hosts | mdata-put root_known_hosts
	fi

	# Receive the information
	znapzend_plans=$(znapzendzetup list 2>/dev/null |\
		sed -n 's/^\*\*\* backup plan: \(.*\) \*\*\*/\1/p')

	# Loop trough all backup plans
	for plan in $znapzend_plans; do
		znapzend_export=$(znapzendzetup export "${plan}")

		# Only edit enabled plans
		if echo "${znapzend_export}" | grep -q "enabled=on"; then
			znapzendzetup edit \
				--recursive \
				--tsformat='%Y-%m-%d-%H%M%S' \
				--donotask \
				--send-delay=$(( ((RANDOM<<15)|RANDOM) % 300 )) \
				SRC "${plan}" \
				DST "${ZNAPZEND_DST_PLAN}" "${ZNAPZEND_DST}/$(hostname)"
		fi
	done
	pkill -HUP znapzend
fi
