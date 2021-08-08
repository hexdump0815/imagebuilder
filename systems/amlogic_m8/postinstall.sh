#!/bin/bash

# there is no hdmi supported you, so disable the lightdm display manager for now
systemctl stop lightdm
systemctl disable lightdm

# just put some generic xorg.conf there although xorg does not make sense here yet
cp -v etc/X11/xorg.conf.d.samples/11-modesetting.conf etc/X11/xorg.conf.d
