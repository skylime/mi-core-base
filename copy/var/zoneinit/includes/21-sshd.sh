#!/usr/bin/env bash
# Disable sshd service by default and provide mdata to reenable the service if
# really needed.

svccfg -s svc:/network/ssh addpg ssh-hostkey-mdata-setup dependency || true
svccfg -s svc:/network/ssh setprop ssh-hostkey-mdata-setup/grouping = astring: require_all || true
svccfg -s svc:/network/ssh setprop ssh-hostkey-mdata-setup/entities = fmri: svc:/network/ssh-hostkey-mdata-setup:default || true
svccfg -s svc:/network/ssh setprop ssh-hostkey-mdata-setup/restart_on = astring: none || true
svccfg -s svc:/network/ssh setprop ssh-hostkey-mdata-setup/type = astring: service || true

svcadm refresh svc:/network/ssh

if ! mdata-get svc_sshd_enable > /dev/null 2>&1; then
  svcadm disable svc:/network/ssh
fi
