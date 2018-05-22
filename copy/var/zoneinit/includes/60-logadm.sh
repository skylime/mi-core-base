# Configure default logadm rotation values

logadm -w '/var/log/authlog'  -A 7d -p 1d -a 'kill -HUP `cat /var/run/*syslog*.pid`'
logadm -w '/var/log/syslog'   -A 7d -p 1d -a 'kill -HUP `cat /var/run/*syslog*.pid`'
logadm -w '/var/adm/messages' -A 7d -p 1d -a 'kill -HUP `cat /var/run/*syslog*.pid`'
logadm -w '/var/log/maillog'  -A 7d -p 1d -a 'kill -HUP `cat /var/run/*syslog*.pid`'
logadm -w '/var/log/munin/*'  -A 7d -p 1d -c
