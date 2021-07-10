#!/bin/bash

if [ "$(arch)" !=  "i686" ]; then
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
  echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
  apt-get update
  apt-get -y install codium
else
  # see: https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/issues/28
  echo ""
  echo "there are no more builds for i686 available"
  echo "the only options is to install the latest available version for i686 = 1.35.1"
  echo ""
  wget https://github.com/VSCodium/vscodium/releases/download/1.35.1/codium_1.35.1-1560422388_i386.deb -P /tmp
  dpkg -i /tmp/codium_1.35.1-1560422388_i386.deb
  rm -f /tmp/codium_1.35.1-1560422388_i386.deb
fi
