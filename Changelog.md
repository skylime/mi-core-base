# Changelog

## 18.4.4

### New

* Add support for core scripts in admin path. [Thomas Merkel]

### Fix

* Ignore dh.pem files. [Thomas Merkel]

## 18.4.3

### New

* Add new LE renew script for cronjob. [Thomas Merkel]
* Add simple motd-cleanup script. [Thomas Merkel]

### Fix

* Fix LE webroot / http port lookup. [Thomas Merkel]
* Fix script for mdata-create-password, provide other options to be quiet if only check is required. [Thomas Merkel]

## 18.4.2

### New

* Add script to add secrets to mdata variables. [Thomas Merkel]
* Add the option to echo the variable if it exits. [Thomas Merkel]

## 18.4.1

### Fix

* Provide fix for py37-certbot to use correct configuration directory. [Thomas Merkel]

## 18.4.0

### New

* Version bump to 18.4.0. [Thomas Merkel]
  Switching to SkyLime munin-node version which is only build with py37.

## 18.3.0

### New

* Provide new postinit feature to run provision tasks after zoneinit.
  [Thomas Merkel]
* Version bump to 18.3.0 minimal-64 [Thomas Merkel]

### Changes

* Remove mdata-setup support and use only existing zoneinit service.
  [Thomas Merkel]

## 18.2.0

### New

* Version bump to 18.2.0. [Thomas Merkel]

### Changes

* Switch to latest smartos-munin-plugins. [Thomas Merkel]
* Switch from bash to ksh93 to use build-in printf as a dateutils
  replacement. [Thomas Merkel]

## 18.1.0

### New

* Version bump to 18.1 with default python version 3.6. [Thomas Merkel]
* Provide default logadm values for syslog information. [Thomas Merkel]
  Add default policy for syslog files:

  - rotate every day
  - delete after 7 days

* Support webroot with ssl-generate.sh. [Thomas Merkel]

## 17.4.2

### New

- Provide an ssl-generator.sh script. [Thomas Merkel]

  Provide function to generate ssl certificates easily with mdata or let's encrypt. Restart services if needed and more.

- Add .bashrc again for root user. [Thomas Merkel]

### Changes

- Remove support for one PEM file which contains cert and key. [Thomas
  Merkel]

### Fix

- Add base64 because its required for spipe config scripts. [Thomas
  Merkel]

## 17.4.1

### Fix

- Fix issue with date on illumos which do not support +14 days. [Thomas
  Merkel]

## 17.4.0

### New

- Version Bump to 17.4.0. [Thomas Merkel]
- Switch from gnudate to dateutils (for munin-plugins as well) [Thomas
  Merkel]

  Because we removed coreutils we need to switch to default tools and additional packages especially for date / dateconv.

- Remove coreutils and findutils, because ls and chmod etc. do not
  support ACLs in gnu-tools. [Thomas Merkel]

### Fix

- Fix readme because we use nullmailer. [Thomas Merkel]

## 17.2.2

### Fix

- Add ssh host keys for ed25519 and ecdsa. [Thomas Merkel]

## 17.2.1

### New

- Update smartos-munin-plugins, cert_expire. [Thomas Merkel]
- Switch to py35-certbot from the Joyent build. [Thomas Merkel]

## 17.2.0

### New

- Version Bump to 17.2.0. [Thomas Merkel]
- Switch to py35 version of certbot. [Thomas Merkel]
- Add sshd_config with only valid options for OpenSSH. [Thomas Merkel]
- Munin plugin version bump to 0.11 with new network stats. [Thomas
  Merkel]
- Nullmailer version bump to 2.0 for 2017Q2. [Thomas Merkel]

### Fix

- Add our own munin-node package and znapzend to fix known perl issues.
  [Thomas Merkel]
- Add sm-prepare-image workaround to fix issue on newer SmartOS
  platform. [Thomas Merkel]
- Provide empty file if addrconf is not set. [Thomas Merkel]

## 17.1.3

### New

* Update nullmailer to version 2.0 [Thomas Merkel]

### Fix

* Add znapzend cronjob for error lookups. [Thomas Merkel]
* Switch to grep -E to support simple regex parameters. [Thomas Merkel]

## 17.1.2

### New

* Update to newest version of smartos munin plugins. [Thomas Merkel]

### Fix

* Fix permissions for check-log script. [Thomas Merkel]

## 17.1.1

### New

* Add check-log script. [Thomas Merkel]

## 17.1.0

### New

* Version bump to 17.1.0. [Thomas Merkel]
* New feature to store root knonw_hosts in mdata variable. [Thomas Merkel]
* Enable cert_expire munin plugin by default. [Thomas Merkel]

### Changes

* Provide the newest version of ssl-expire.sh. [Thomas Merkel]
* Update munin plugins to v0.9. [Thomas Merkel]

## 16.4.7

### New

* Provide new version of ssl-letsencrypt.sh which also support webroots. [Thomas Merkel]

### Fix

* Switch from 31day warning to 14day warning. [Thomas Merkel]

## 16.4.6

### Other

* Update to newest munin-plugins version. [Thomas Merkel]

## 16.4.5

### Changes

* Let&#x27;s encrypt add pre,post and renew hook scripts which could be used later in any other image. [Thomas Merkel]

## 16.4.4

### Fix

* Fix parameter issue for ssl-selfsigned.sh. [Thomas Merkel]
* Fix error and return value in let&#x27;s encrypt script. [Thomas Merkel]
* Remove wrong information from README. [Thomas Merkel]

## 16.4.3

### New

* Letsencrypt helper scripts. [Thomas Merkel]
* Add grep as default command for all images. [Thomas Merkel]
* Use gsed to replace skylime repository for pkgsrc. [Thomas Merkel]

### Changes

* Remove rsyslog from core-base. [Thomas Merkel]

  We will disable the support for rsyslog remote logging because it didn&#x27;t worked
  that well based on caching and memory issues. We will continue to use the default
  rsyslog provided from the global zone / base.

### Other

* Fix typo and add full path to the cron call. [Thomas Merkel]
* Update readme and manifest for admin ssh keys. [Thomas Merkel]

## 16.4.2

### Fix

* Rename 05-delegated-dataset.sh to 04-... because it should not be overwritten from child datasets. [Thomas Merkel]

## 16.4.1

### Fix

* Fix pkgsrc version issue on customize script. [Thomas Merkel]

## 16.4.0

### New

* Update to base-16Q4 release. [Thomas Merkel]

## 16.3.0

### New

* Provide support for delegated dataset to the &quot;admin&quot; user. [Thomas Merkel]

  This feature automatically configure a delegated dataset to the &quot;admin&quot; user and provides an extra mdata-variable which allow SSH key deployment for the &quot;admin&quot; user. We consider for disabling the login as &quot;root&quot; which is not required anymore because of the &quot;admin&quot;-users sudo privileges.

### Other

* Version upgrade to 16.3.1 base64 image from Joyent. [Thomas Merkel]

## 16.2.2

### New

* Disable in.ndp log spam if addrconf isn&#x27;t used. [Thomas Merkel]

### Fix

* Fix issue with wrong naming for root_ssh_rsa.pub mdata. [Thomas Merkel]

## 16.2.1

### Fix

* Version bump to 16.2.1. [Thomas Merkel]
* Fix issue with wrong pkgsrc version in base image. [Thomas Merkel]

## 16.2.0

### New

* Update to new base version 16.2.0. [Thomas Merkel]

## 16.1.0

### New

* Allowed statless addrconf. [tschaefer]
* Default UTF-8 support for root users shell. [Thomas Merkel]
* Version bump to 16.1.0 minimal64. [Thomas Merkel]

## 15.4.1

### Fix

* Disable fm/smtp-notify because of reboot issue. [Thomas Merkel]

	We detected an issue that the server isn&#x27;t stopped somehow during
	reboot of the zone. This error happen sometimes and is currenlty not all
	time reproducible. But the zone will freeze and could only be restarted by
	restarting the global zone. For that reason we disabled the notificateion
	service again.

  https://github.com/wiedi/deploy-zone/commit/4ad54bd07ab11933c4d21a55c4e7c794e5a998da

## 15.4.0

### New

* Enable smtp notify service. [Thomas Merkel]
* Add bashrc for root user from default. [Thomas Merkel]
* Add gsed as default package to base. [Thomas Merkel]

### Fix

* Find issue with crt lookup. [Thomas Merkel]
* Store FQDN for nullmailer in me file. [Thomas Merkel]

### Other

* Provide SVC log functions from global zone to zones. [Thomas Merkel]

  The functions help a lot for debugging and you don&#x27;t need to know
  the full command :-)

* Use FQDN for PS1. [Thomas Merkel]

  We use a cloud based environment, so most of the time some servers have the
  same name but different FQDN.

# 15.3.0

### New

* Update to new version 15.3.0 [Tobias Schäfer]

  Use new minimal base image from joyent and latest pkgsrc release.
  Update manifest to new version.

### Fix

* Complete mdata description in manifest JSON file. [Tobias Schäfer]
* Adapt README. [Tobias Schäfer]

## 15.1.3

### New

* We also need findutils for gnufind. [Thomas Merkel]

## 15.1.2

### Fix

* We require coreutils for many script on our system so we install that by default. [Thomas Merkel]

## 15.1.1

### New

* Sudo is required on many images. [Thomas Merkel]
* Install base64 as default tool and also add znapzend as default backup tool. [Thomas Merkel]

## 15.1.0

### New

* Update to new version 15.1.0. [Thomas Merkel]

  Use new minimal base image from joyent. Be sure we're using pkgsrc nullmailer
  version. Update manifests to new version.

## 14.4.2

### Fix

* Script for ssh host key setup. [Thomas Merkel]

  The script only should run once and disable itself. It should also be not
  enabled by default and should be started by an extra mdata / zoneinit script.

### Changes

* Version bump because of minimal change. [Thomas Merkel]
* The core smf should be started before other core scripts run. [Thomas Merkel]

## 14.4.1

### New

* Add own wrapper for our personal SMF scripts which should be included / imported. [Thomas Merkel]
* Add manifest and method for storing ssh keys in mdata variable. [Thomas Merkel]
* We create an extra sshd host key mdata script. [Thomas Merkel]

### Changes

* Switch to own rsyslog config for the future. [Thomas Merkel]
* Rename / copy the rsyslog config from system to pkgsrc. [Thomas Merkel]
* Disable systemlog and use pkgsrc rsyslog version. [Thomas Merkel]

  We would like to have gnutls for rsyslog. So we disable system
  log which is also rsyslog and install the new rsyslog version
  including gnutls module.

### Other

* We would like to use the minimal version for base image. [Thomas Merkel]
* Update to newest 14.4.1 base. [Thomas Merkel]

## 14.4.0

### New

* Version update to 14.4.0 release. [Thomas Merkel]

	This patch is created by @wiedi. We switch from postfix to nullmailer.
	By default the new minimal base image didn't contain any mailing
	daemon so we remove the postfix configuration scripts and replace them
	with an nullmailer setup.

* Our own packages are signed with pkgsrc@skylime.net GPG key. [Thomas Merkel]

	We replace the current keyring with a new one which contains the
	public key from Joyent and from SkyLime

### Changes

* Set hostname for nullmailer smtp out. [Thomas Merkel]
* Enable nullmailer by default if smarthost exists. [Thomas Merkel]
* update pkgsrc version. [Thomas Merkel]
* Modify to use the new script to generate the munin plugins. [Thomas Merkel]

### Other

* remove debug output. [Thomas Merkel]
* Allow also env variables for PLUGINS. [Thomas Merkel]
* Add first version of munin-node-plugins script. [Thomas Merkel]
* release of new munin plugins (support more dovecot logs) [Thomas Merkel]
* add tool ccze for colored log output. [Thomas Merkel]

## 14.2.9

### Changes

* update changelog. [Thomas Merkel]
* version update for last patches. [Thomas Merkel]

### Other

* version bump. [Thomas Merkel]
* update smartos munin plugins. [Thomas Merkel]
* Enable svc service by email. [Thomas Merkel]

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
