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

sed -i "s,${DEFAULT_USERNAME}:,${1}:,g" /etc/passwd
sed -i "s,${DEFAULT_USERNAME}:,${1}:,g" /etc/shadow
sed -i "s,${DEFAULT_USERNAME}:,${1}:,g" /etc/group
sed -i "s,:${DEFAULT_USERNAME},:${1},g" /etc/group
sed -i "s/,${DEFAULT_USERNAME}/,${1}/g" /etc/group
mv /home/${DEFAULT_USERNAME} /home/${1}
