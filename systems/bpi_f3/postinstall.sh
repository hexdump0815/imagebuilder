#!/bin/bash

# this is something for later when the gpu is working well
#cp -v etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf etc/X11/xorg.conf.d
#cp -v etc/X11/xorg.conf.d.samples/13-pvr-swapped-dri-nodes.conf etc/X11/xorg.conf.d

# in the meantime lets use the framebuffer for xorg - not fancy, but shoudl work well
cp -v etc/X11/xorg.conf.d.samples/11-fbdev.conf etc/X11/xorg.conf.d

# install the required remoteproc firmware
cp -v postinstall/esos.elf lib/firmware
