#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

if [ "$#" != "1" ]; then
  echo ""
  echo "usage: $0 arch release"
  echo ""
  echo "possible arch options:"
  echo "- armv7l - 32bit"
  echo "- aarch64 - 64bit"
  echo ""
  echo "example: $0 armv7l"
  echo ""
  exit 1
fi

if [ $(uname -m) != ${1} ]; then
  echo ""
  echo "the target arch ${1} is not the same arch this system is running on: $(uname -m) - giving up"
  echo ""
  exit 1
fi

export OFFLINE_DIR=/compile/local/imagebuilder-offline

if [ -d ${OFFLINE_DIR} ]; then
  echo ""
  echo "please delete the OFFLINE_DIR ${OFFLINE_DIR} first to be able to create a fresh one"
  echo ""
  exit 1
fi

# create downloads dir
mkdir -p ${OFFLINE_DIR}

# exit on errors
set -e

# get version information for below
. scripts/versions.conf

# run the get-files.sh script for all systems
for i in $(ls systems); do
  if [ $(cat systems/${i}/arch.txt) = ${1} ]; then
    echo ""
    echo "- getting files for $i:" 
    echo ""
    # set DOWNLOAD_DIR to OFFLINE_DIR
    export DOWNLOAD_DIR=${OFFLINE_DIR}
    . systems/${i}/get-files.sh ${i} ${1}
    echo ""
  fi
done
