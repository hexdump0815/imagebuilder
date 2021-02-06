#!/bin/bash

echo "/opt/mesa-aarch64/lib/aarch64-linux-gnu" > etc/ld.so.conf.d/aaa-mesa.conf

mv usr/lib/aarch64-linux-gnu/dri usr/lib/aarch64-linux-gnu/dri.org
ln -s /opt/mesa-aarch64/lib/aarch64-linux-gnu/dri usr/lib/aarch64-linux-gnu/dri

echo "snd_bcm2835" >> etc/modules
