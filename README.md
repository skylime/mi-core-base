# mi-core-base

Please refer to https://github.com/joyent/mibe for use of this repo.

## description

Basic core.io mibe image with default setup of infrastructure services like
munin and remote syslog. This should be the default image for all core.io zones.

## mdata variables

### munin

- `munin_master`: List of ip addresses of the munin master servers

### remote syslog

- `syslog_host`: IP address or hostname of the remote log server
- `syslog_ssl`: CA certificate of the remote log server
