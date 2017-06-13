#!/usr/bin/env bash
# This script will try to monitor your log file and output
# to stderr if some error matches and is newer than the old
# error.
PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin

# Parameters to provide
file="${1}"
lookup=${2-"error"}
lines=5

# Verify parameters and file
if [[ -z "${file}" ]]; then
	echo "${0} [file] [lookup]"
	exit 1
fi
if [[ ! -f ${file} ]]; then
	exit 2
fi

# Temporary files required
tempfile="/tmp/$(basename ${file})"
touch "${tempfile}.current" "${tempfile}.last"

# Lookup
grep -E "${lookup}" "${file}" | tail -n${lines} > "${tempfile}.current"
if ! diff "${tempfile}.last" "${tempfile}.current" >/dev/null 2>&1; then
	cat "${tempfile}.current" 1>&2
fi
cat "${tempfile}.current" > "${tempfile}.last"
