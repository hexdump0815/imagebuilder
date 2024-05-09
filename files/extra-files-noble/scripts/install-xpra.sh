#!/bin/bash

# install the official latest stable xpra version as the version in jammy is too old
wget -qO - https://xpra.org/gpg.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/xpra.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/xpra.gpg] https://xpra.org/beta/ noble main' | sudo tee /etc/apt/sources.list.d/xpra.list
apt-get update
apt-get -y install xpra xvfb
