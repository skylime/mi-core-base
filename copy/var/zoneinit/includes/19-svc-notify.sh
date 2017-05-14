# svc notify
# Enable notification by email for all services
start=`date +%s`

svccfg setnotify -g from-online,to-maintenance mailto:root@localhost
svccfg setnotify problem-diagnosed,problem-updated mailto:root@localhost

end=`date +%s`
log "debug (sec): $((end-start))"
