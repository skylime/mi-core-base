# Changelog

## 14.2.8

### Changes

* version update for last patches. [Thomas Merkel]

### Other

* Enable svc service by email. [Thomas Merkel]

## 14.2.7 (2014-10-07)

### New

* version bump for mibe image. [Thomas Merkel]
* add ssh private key mdata option for root user. [Thomas Merkel]

    We would like to store the public and private ssh key for the root
    user in mdata. This allow us to have that information after
    reprovision a zone. The only valid key must be an rsa key and the
    public key ist mostly not required by the system.

* add logtail with the pkg logcheck. [Thomas Merkel]

### Changes

* update changelog file. [Thomas Merkel]
* update to new munin scripts. [Thomas Merkel]

## 14.2.6 (2014-10-06)

### New

* add dtracetools for debugging to base update version number. [Thomas Merkel]
* add dtracetools for debugging to base. [Thomas Merkel]

### Changes

* update changelog. [Thomas Merkel]

## 14.2.5 (2014-10-02)

### New

* version update. [Thomas Merkel]
* add leading number to the rsyslog remote log config file. [Thomas Merkel]
* add additional default configuration for rsyslog. [Thomas Merkel]

## 14.2.4 (2014-09-28)

### New

* add new munin plugin version and version update for base image. [Thomas Merkel]

### Changes

* update changelog file. [Thomas Merkel]

## 14.2.3 (2014-09-27)

### Other

* update changelog. [Thomas Merkel]
* yes we know what we are doing, so please install rsyslog. [Thomas Merkel]

## 14.2.2 (2014-09-23)

### Other

* update changelog. [Thomas Merkel]
* update changelog. [Thomas Merkel]
* update version. [Thomas Merkel]
* install rsyslog via customize script. [Thomas Merkel]
* use new version of rsyslog. [Thomas Merkel]

## 14.2.1 (2014-09-23)

### Other

* version update. [Thomas Merkel]
* version update. [Thomas Merkel]
* update license file. [Thomas Merkel]
* missing rsyslog gnutls. [Thomas Merkel]

## 14.2.0 (2014-09-21)

### Other

* add changelog. [Thomas Merkel]
* svcadm refresh is required to have new config enabled. [Thomas Merkel]
* fix readme. [Thomas Merkel]
* update readme file. [Thomas Merkel]
* Expired mozilla root ca's aren't my business so don't warn me for that. [Thomas Merkel]
* Disable StatelessAddrConf for all interfaces. [Thomas Merkel]

    We configure ipv6 manually and ndpd spams to the log file every minute
    with &quot;in.ndpd[2477]: [ID 102006 daemon.error] prefix_update_k(net1,
    net1:2, xxxx:xx:xxx:xxx::/64) from  to ONLINK AUTO  name is already
    allocated&quot;

* run postalias. [Thomas Merkel]
* fix subshell file cat. [Thomas Merkel]
* add munin plugin pkg_audit. [Thomas Merkel]
* update to new smartos munin configs. [Thomas Merkel]
* we will not check for ssl certificates in /etc anymore. [Thomas Merkel]
* don't graph ramdisk iops. [Sebastian Wiedenroth]
* be sure we skip the directory on extract. [Thomas Merkel]
* ups. [Thomas Merkel]
* move munin plugin configuration to customize. [Thomas Merkel]
* create cronjob for ssl-expire check. [Thomas Merkel]
* add script that check ssl expire. [Thomas Merkel]
* configre ssh host keys via mdata for reprovisioning. [Thomas Merkel]
* be sure you create an ssh dir. [Thomas Merkel]
* Add mdata support for ssh root_authorized_keys. [Thomas Merkel]
* add spiped-configure script. [Thomas Merkel]
* allow also mail send without authentication. [Thomas Merkel]
* enable postfix. [Thomas Merkel]
* configure postfix with smarthost, user authentication and root email. [Thomas Merkel]
* modify readme for mdata value for postfix. [Thomas Merkel]
* Add postfix minimal configuration. [Thomas Merkel]
* use skylime pkgsrc mirror. [Thomas Merkel]
* fix version information. [Thomas Merkel]
* support more than one dot. [Thomas Merkel]
* support munin hostnames. [Thomas Merkel]
* add mdata information to readme. [Thomas Merkel]
* Add remote logging server variables. [Thomas Merkel]
* add description. [Thomas Merkel]
* Add munin-node as default. [Thomas Merkel]
* add first idea of metadata extra information. [Thomas Merkel]
* add default pkgs. [Thomas Merkel]
* Add mdata setup scripts and zoneinit. [Thomas Merkel]
* add manifest for base image. [Thomas Merkel]
* first import basics for base mibe. [Thomas Merkel]
