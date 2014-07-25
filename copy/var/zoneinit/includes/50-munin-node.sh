# Setup munin-node default plugins

MUNIN_PLUGIN_SRC='/opt/local/lib/munin/plugins'
MUNIN_PLUGIN_DST='/opt/local/etc/munin/plugins'

# Enable plugins as destination name (for example if_net0)
MUNIN_PLUGINS=(
	'cpu'
	'df'
	'iostat'
	'load'
	'uptime'
	'users'
	'vmstat'
	'io_busy_ramdisk'
	'io_busy_sd'
	'io_busy_zfs'
	'io_bytes_ramdisk'
	'io_bytes_sd'
	'io_bytes_zfs'
	'io_ops_ramdisk'
	'io_ops_sd'
	'io_ops_zfs'
	'if_net0'
)

for plugin in "${MUNIN_PLUGINS[@]}"; do
	if [ ! -x ${MUNIN_PLUGIN_SRC}/${plugin} ]; then
		plugin_src=${plugin%_*}_
		[ ! -x ${MUNIN_PLUGIN_SRC}/${plugin_src} ] && \
			plugin_src=${plugin_src%%_*}_
	else
		plugin_src=${plugin}
	fi
	if [[ -x ${MUNIN_PLUGIN_SRC}/${plugin_src} ]]; then
		ln -sf ${MUNIN_PLUGIN_SRC}/${plugin_src} ${MUNIN_PLUGIN_DST}/${plugin}
	fi
done

# Enable munin service
/usr/sbin/svcadm enable svc:/pkgsrc/munin-node:default
