#!/bin/bash

# block update of the installed mesa packages as some of their contents get changed
apt-mark hold libgl1-mesa-dri mesa-va-drivers

# symlink the own mesa dri drivers into the system - on debian there seems to be no
# other way - the /etc/environtment* approach working for ubuntu does not seem to work
if [ "${2}" = "armv7l" ] && [ -d /opt/mesa/lib/arm-linux-gnueabihf/dri ] ; then
  mv /usr/lib/arm-linux-gnueabihf/dri /usr/lib/arm-linux-gnueabihf/dri.org
  ln -s /opt/mesa/lib/arm-linux-gnueabihf/dri /usr/lib/arm-linux-gnueabihf/dri
elif [ "${2}" = "aarch64" ] && [ -d /opt/mesa/lib/aarch64-linux-gnu/dri ] ; then
  mv /usr/lib/aarch64-linux-gnu/dri /usr/lib/aarch64-linux-gnu/dri.org
  ln -s /opt/mesa/lib/aarch64-linux-gnu/dri /usr/lib/aarch64-linux-gnu/dri
fi
