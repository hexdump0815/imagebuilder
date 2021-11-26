#!/bin/bash

# better check /etc/default/keyboard if it looks as expected after this has been run
# on some chromebooks for instance it seems to have problems to detect the keyboard
# at all and skips the keyboard setup completely - then just edit the above file by
# hand
dpkg-reconfigure keyboard-configuration
if [ ! -f /etc/debian_version ]; then
  # activate new setting on the console if virtual console is used
  setupcon
fi
dpkg-reconfigure tzdata
dpkg-reconfigure locales
