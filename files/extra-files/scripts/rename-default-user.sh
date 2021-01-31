#!/bin/bash

DEFAULT_USERNAME=linux

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 <new-username>"
  echo ""
  echo "new-username should be a normal and simple string"
  echo "example: $0 joe"
  echo ""
  exit 1
fi

if [ ! -d /home/linux ]; then
  echo ""
  echo "looks like this user does not exist (no /home/${DEFAULT_USERNAME}) - so nothing to do"
  echo ""
  exit 1
fi

groupadd ${1}
usermod -d /home/${DEFAULT_USERNAME} -m -g ${DEFAULT_USERNAME} -l ${DEFAULT_USERNAME} ${1}
