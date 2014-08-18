# mi-core-base

Please refer to https://github.com/joyent/mibe for use of this repo.

## description

Basic core.io mibe image with default setup of infrastructure services like
munin and remote syslog. This should be the default image for all core.io zones.

## mdata variables

### munin

- `munin_master`: List of ip addresses or hostnames of the munin master servers

### remote syslog

- `syslog_host`: IP address or hostname of the remote log server

### postfix

- `mail_smarthost`: hostname of remote smtp server
- `mail_auth_user`: smtp username for authentication
- `mail_auth_pass`: smtp password for authentication
- `mail_adminaddr`: admin email address for everything from root@localhost
