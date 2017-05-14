# Enable munin service
start=`date +%s`

/usr/sbin/svcadm enable svc:/pkgsrc/munin-node:default

end=`date +%s`
log "debug (sec): $((end-start))"
