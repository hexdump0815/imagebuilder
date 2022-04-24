#!/bin/bash

# it looks like there is no xpra version available yet for jammy, so install the jammy default one meanwhile
apt-get -y install xpra

# # install the official latest stable xpra version as the version in jammy it too old

# wget -qO - https://xpra.org/gpg.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/xpra.gpg
# echo 'deb [signed-by=/etc/apt/trusted.gpg.d/xpra.gpg] https://xpra.org/ jammy main' | sudo tee /etc/apt/sources.list.d/xpra.list
# apt-get update
# apt-get -y install xpra
