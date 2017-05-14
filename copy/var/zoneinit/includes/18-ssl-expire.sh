# create cronjob for ssl-expire script
start=`date +%s`

CRON='0 9 * * 1 /opt/core/bin/ssl-expire.sh'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

end=`date +%s`
log "debug (sec): $((end-start))"
