#!/usr/bin/env bash

if mdata-get svc_sshd_enable > /dev/null 2>&1; then
    svcadm enable svc:/network/ssh-hostkey-mdata-setup:default
fi
