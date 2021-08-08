#!/bin/bash

# there is no hdmi supported you, so disable the lightdm display manager for now
systemctl stop lightdm
systemctl disable lightdm
