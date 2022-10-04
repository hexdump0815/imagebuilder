#!/bin/bash

# the v5.4 kernel does not work well together with the nouveau gpu driver, so this is not required yet
## disable default xorg server and use the own built one instead
#apt-mark hold xserver-xorg-core
#mv -v /usr/lib/xorg/Xorg /usr/lib/xorg/Xorg.org
#ln -sv /opt/xserver/bin/Xorg /usr/lib/xorg/Xorg

if [ "${3}" = "bullseye" ]; then
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
fi
