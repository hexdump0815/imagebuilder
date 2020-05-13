#!/bin/bash

echo "/opt/mesa-armv7l/lib/arm-linux-gnueabihf" > etc/ld.so.conf.d/aaa-mesa.conf

mv usr/lib/arm-linux-gnueabihf/dri usr/lib/arm-linux-gnueabihf/dri.org
ln -s /opt/mesa-armv7l/lib/arm-linux-gnueabihf/dri usr/lib/arm-linux-gnueabihf/dri
