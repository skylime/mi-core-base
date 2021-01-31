log "cleaning up"

svccfg -s postinit 'setprop application/done = true'
svcadm refresh postinit
