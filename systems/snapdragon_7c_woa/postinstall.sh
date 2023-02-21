#!/bin/bash

cp -v etc/X11/xorg.conf.d.samples/11-fbdev.conf etc/X11/xorg.conf.d
cp -v etc/X11/xorg.conf.d.samples/51-touchpad.conf etc/X11/xorg.conf.d

# install the qcom tools qrtr-ns and rmtfs
tar xzf postinstall/qcom-tools-${2}-${3}.tar.gz
