#!/bin/bash

# the v5.4 kernel does not work well together with the nouveau gpu driver, so this is not required yet
## disable default xorg server and use the own built one instead
#apt-mark hold xserver-xorg-core
#mv -v /usr/lib/xorg/Xorg /usr/lib/xorg/Xorg.org
#ln -sv /opt/xserver/bin/Xorg /usr/lib/xorg/Xorg
echo "nothing to be done here yet ..."
