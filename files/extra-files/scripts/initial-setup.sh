#!/bin/bash

dpkg-reconfigure keyboard-configuration
if [ ! -f /etc/debian_version ]; then
  # activate new setting on the console if virtual console is used
  setupcon
fi
dpkg-reconfigure tzdata
dpkg-reconfigure locales
