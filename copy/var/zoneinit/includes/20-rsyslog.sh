# Disable system log
/usr/sbin/svcadm disable svc:/system/system-log:default
# Enable rsyslog installed by pkgsrc
/usr/sbin/svcadm enable svc:/pkgsrc/rsyslog:default
