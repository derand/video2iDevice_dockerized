#!/bin/sh

set -e
SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
    # Checks for USERNAME variable
    if [ -z "$USERNAME" ]; then
      echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=john).'
      exit 1
    fi
    # Checks for PASSWORD variable
    if [ -z "$PASSWORD" ]; then
      echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=hackme).'
      exit 1
    fi
    # Modify settings.json
    sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
    sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS

    if [ -n "CLIENT_IP" ]; then
      sed -i.bak -e "s/#rpc-whitelist#/,$CLIENT_IP/" $SETTINGS
    else
      sed -i.bak -e "s/#rpc-whitelist#//" $SETTINGS
    fi
fi

unset PASSWORD USERNAME

mkdir -p /data/transmission

exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
