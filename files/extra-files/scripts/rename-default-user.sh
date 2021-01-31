#!/bin/bash

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 <new-username>"
  echo ""
  echo "new-username should be a normal and simple string"
  echo "example: $0 joe"
  echo ""
  exit 1
fi

groupadd ${1}
usermod -d /home/linux -m -g linux -l linux ${1}
