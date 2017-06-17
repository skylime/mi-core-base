# https://github.com/joyent/smartos-live/issues/501
if mdata-get sdc:nics | grep -qv addrconf 1>/dev/null 2>&1; then
	echo '# https://github.com/joyent/smartos-live/issues/501' > /etc/inet/ndpd.conf
	echo 'ifdefault StatelessAddrConf off'                    >> /etc/inet/ndpd.conf
else
	echo > /etc/inet/ndpd.conf
fi
