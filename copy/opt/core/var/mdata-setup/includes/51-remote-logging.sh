#!/bin/bash
# Create remote logging file if mdata is configured

RSYSLOG_CONF_D='/opt/local/etc/rsyslog.d/'

echo '# remote-logging' > ${RSYSLOG_CONF_D}/remote-logging.conf
if mdata-get syslog_host 1>/dev/null 2>&1; then
	# Allow only ssl for remote logging
	echo '# use tls'                            >> ${RSYSLOG_CONF_D}/remote-logging.conf
	echo '$DefaultNetstreamDriver gtls'         >> ${RSYSLOG_CONF_D}/remote-logging.conf
	echo '$ActionSendStreamDriverMode 1'        >> ${RSYSLOG_CONF_D}/remote-logging.conf
	echo '$ActionSendStreamDriverAuthMode anon' >> ${RSYSLOG_CONF_D}/remote-logging.conf
	echo "\$DefaultNetstreamDriverCAFile /etc/ssl/certs/ca-certificates.crt" \
		>> ${RSYSLOG_CONF_D}/remote-logging.conf
	# Setup remote logging host
	echo '# send (all) messages'        >> ${RSYSLOG_CONF_D}/remote-logging.conf
	echo "*.* @@$(mdata-get syslog_host)" >> ${RSYSLOG_CONF_D}/remote-logging.conf
fi

# Restart rsyslog after config change
svcadm restart svc:/pkgsrc/rsyslog:default
