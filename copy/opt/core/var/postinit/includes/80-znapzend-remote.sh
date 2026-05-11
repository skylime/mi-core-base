#!/usr/bin/env bash
# Configure remote backup server if available and present via mdata variable.
# Modify all existing znapzendzetups.

# Only works if ssh key is present. Otherwise no backup is possible.
ls ~/.ssh/id_* &>/dev/null || { echo "No SSH keys found"; exit 0; }

# Default znapzend zetup plan if not present via mdata
ZNAPZEND_DST_PLAN_DEFAULT="7days=>8hours,30days=>1day,1year=>1week,10years=>1month"

# Restrucutre data to bash arrays for better handling in loops
mapfile -t ZNAPZEND_DST_PLANS < <(mdata-get znapzend_dst_plan 2>/dev/null | tr ' ' '\n' | grep -v '^$')
mapfile -t ZNAPZEND_DSTS < <(mdata-get znapzend_dst 2>/dev/null | tr ' ' '\n' | grep -v '^$')

# Only do any zetup if anything is in the DSTS array.
for (( i=0; i<${#ZNAPZEND_DSTS[@]}; i++ )); do
	ZNAPZEND_DST="${ZNAPZEND_DSTS[$i]}"
	ZNAPZEND_DST_PLAN=${ZNAPZEND_DST_PLANS[$i]:-${ZNAPZEND_DST_PLAN_DEFAULT}}

	# Verify requirements (root id_rsa, known_hosts)
	ZNAPZEND_DST_HOST=$(echo "${ZNAPZEND_DST}" | sed -n 's/\(.*@\)\?\(.*\):.*/\2/p')
	if ! grep -q "${ZNAPZEND_DST_HOST}" /root/.ssh/known_hosts &>/dev/null; then
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
done
