# Run mdata setup on provision state
start=`date +%s`

/opt/core/bin/mdata-setup

end=`date +%s`
log "debug (sec): $((end-start))"
