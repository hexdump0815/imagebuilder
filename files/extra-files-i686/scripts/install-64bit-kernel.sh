#!/bin/bash

# first check if the regular debian i686 kernel is installed and running and no special one
uname -r | grep -q '686$'
if [ "$?" = "0" ]; then
  echo ""
  echo "installing the 64bit linux kernel package"
  echo ""
  dpkg --add-architecture amd64
  apt-get update
  apt-get -yq install linux-image-amd64
else
  echo ""
  echo "it looks like the regular i686 kernel (linux-image-686) is not in use - better doing nothing in this case"
  echo ""
fi
