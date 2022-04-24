#!/bin/bash

# just remove the jammy default xpra until there is a newer upstream version available
apt-get -y remove --purge xpra

# apt-get -y remove --purge xpra
# rm -f /etc/apt/trusted.gpg.d/xpra.gpg
# rm -f /etc/apt/sources.list.d/xpra.list
# apt-get update
# apt-get -y auto-remove
