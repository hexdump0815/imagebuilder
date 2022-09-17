#!/bin/bash

apt-get -y remove --purge xpra xvfb
rm -f /etc/apt/trusted.gpg.d/xpra.gpg
rm -f /etc/apt/sources.list.d/xpra.list
apt-get update
apt-get -y auto-remove
