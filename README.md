# mi-core-base

This repository is based on [Joyent mibe](https://github.com/joyent/mibe).

## description

Basic core.io mibe image with default setup of infrastructure services like
munin and remote syslog. This should be the default image for all core.io zones.

## mdata variables

### root authorized_keys

Configure ssh public key for root user via `mdata` variable.

- `root_authorized_keys`: ssh public key for the root user

### root ssh public private key

Configure ssh public and private key pair for root user via `mdata`. We only
support rsa keys.

- `root_ssh_rsa`: private ssh rsa key for root user
- `root_ssh_rsa_pub`: public ssh key for root user (mostly not required)

### munin

List of ip addresses of the munin master server that is allowed to connect. The ip addresses should be seperated by whitespace or newline.

- `munin_master_allow`: ip addresses (alternative hostname) of the munin master node

### rsyslog

Remote syslog server that accept syslog tcp connections on specified port. We use our [mi-core-logger](https://github.com/skylime/mi-core-logger) image for that.

- `syslog_host`: ip address and port seperated by colon of the remote syslog server

### postfix

To have cron emails on errors we like to configure postfix as local smtp server.

- `mail_smarthost`: hostname of remote smtp server
- `mail_auth_user`: smtp username for authentication
- `mail_auth_pass`: smtp password for authentication
- `mail_adminaddr`: admin email address for everything from root@localhost

### ssh daemon

Configure ssh public and private key pairs for the host daemon via `mdata`.

- `ssh_host_rsa_key`:     private SSH rsa key
- `ssh_host_rsa_key.pub`: public SSH rsa key
- `ssh_host_dsa_key`:     private SSH dsa key
- `ssh_host_dsa_key.pub`: public SSH dsa key

