#!/bin/bash

crt_locations=${crt_locations-'/etc /opt/local/etc'}
today_unixtime=$(date +%s)
trigger_unixtime=$(date +%s -d "+31 days")

for location in ${crt_locations}; do
	[ ! -d "${location}" ] && continue
	crts=$(find ${location} -type f -iname *.pem -o -iname *.crt)
	for crt in ${crts}; do
		subject=$(openssl x509 -in ${crt} -subject -noout | sed 's:.*/CN=\(.*\)$:\1:g')
		expire_unixtime=$(date --date="$(openssl x509 -in ${crt} -enddate -noout | cut -d= -f 2)" +%s)
		expire_datetime=$(date +"%Y-%m-%d" -d "@${expire_unixtime}")

		# expired
		if [ ${today_unixtime} -gt ${expire_unixtime} ]; then
			critical[${#critical[*]}]="${expire_datetime}: ${subject} (${crt})"
		# expire during trigger unixtime
		elif [[ ${expire_unixtime} -lt ${trigger_unixtime} && ${expire_unixtime} -gt ${today_unixtime} ]]; then
			warning[${#warning[*]}]="${expire_datetime}: ${subject} (${crt})"
		fi
	done
done

# Output
if [[ "${critical}" ]]; then
	echo "EXPIRED: "
	(for c in "${critical[@]}"; do
		echo " ${c}"
	done) | sort -M -k 2
fi

if [[ "${warning}" ]]; then
	echo "EXPIRE SOON: "
	(for w in "${warning[@]}"; do
		echo " ${w}"
	done) | sort -M -k 2
fi
