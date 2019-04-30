#!/usr/bin/env bash
# Create random password and store it in an local mdata variable.

##
## Functions
##
usage() {
	cat <<- EOF
	${0} [-f|-q] -m MDATA_VAR [-s SECRET]
	Store secret in mdata variable and output the generated secret
	if not provided.

	OPTIONS:
	  -f           : Force insert also if variable exists
	  -q           : Quiet, do not output any secret
	  -m MDATA_VAR : Create secret and store it in MDATA_VAR
	  -s SECRET    : Provide own secret
	EOF
	exit 1
}

die() {
	cat <<< "$@" 1>&2;
	exit 2
}

mdata_put() {
	local mdata_var=${1}
	local secret=${2}
	if ! mdata-put ${mdata_var} "${secret}" >/dev/null 2>&1; then
		die "Could not store secret in variable: ${mdata_var}"
	fi
}

##
## Options
##
while getopts "m:s:fqh" arg; do
	case "${arg}" in
		m) mdata_var=${OPTARG} ;;
		s) secret=${OPTARG}    ;;
		f) force=1             ;;
		q) quiet=1            ;;
		*) usage               ;;
	esac
done
shift $((OPTIND-1))

[ -z ${mdata_var+x} ] && usage

##
## Main
##
# Generate secret if not provided
[ -z ${secret+x} ] && \
	secret=$(LC_ALL=C tr -cd '[:alnum:]' < /dev/urandom | head -c64)

# Check if mdata variable is already set
if ! mdata-get ${mdata_var} >/dev/null 2>&1 || [ -n "${force}" ]; then
	# No mdata variable exists or force is used
	mdata_put ${mdata_var} "${secret}"
else
	[ -n "${quiet}" ] && exit 3
fi

# No output if quiet is set, exit code above will be used
if [ ! -n "${quiet}" ]; then
	mdata-get ${mdata_var}
fi
