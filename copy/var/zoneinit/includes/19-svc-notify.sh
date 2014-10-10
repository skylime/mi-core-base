# svc notify
# Enable notification by email for all services

svccfg setnotify -g from-online,to-maintenance mailto:root@localhost
svccfg setnotify problem-diagnosed,problem-updated mailto:root@localhost
