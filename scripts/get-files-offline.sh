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
  echo "- i686 - 32bit"
  echo "- x86_64 - 64bit"
  echo "- riscv64 - 64bit (wip)"
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
  echo "please delete the offline dir ${OFFLINE_DIR} first to be able to create a fresh one"
  echo ""
  exit 1
fi

# create downloads dir
mkdir -p ${OFFLINE_DIR}

# exit on errors
set -e

# get version information for below
. scripts/versions.conf

POSSIBLE_TARGET_HOST="none"

if [ "${1}" = "armv7l" ] || [ "${1}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
fi

if [ "${1}" = "i686" ] || [ "${1}" = "x86_64" ]; then
  POSSIBLE_TARGET_HOST="x86_64"
fi

# run the get-files.sh script for all systems
for i in $(ls systems); do
  if [ "$(cat systems/${i}/arch.txt)" = "${1}" ]; then
    echo ""
    echo "- getting files for $i:" 
    echo ""
    # set DOWNLOAD_DIR to OFFLINE_DIR
    export DOWNLOAD_DIR=${OFFLINE_DIR}
    . systems/${i}/get-files.sh ${i} ${1} ${2}
    echo ""
  fi
  # do the same for the possible target hosts
  if [ "$(cat systems/${i}/arch.txt)" = "${POSSIBLE_TARGET_HOST}" ]; then
    echo ""
    echo "- getting files for ${POSSIBLE_TARGET_HOST}:"
    echo ""
    # set DOWNLOAD_DIR to OFFLINE_DIR
    export DOWNLOAD_DIR=${OFFLINE_DIR}
    . systems/${i}/get-files.sh ${i} ${POSSIBLE_TARGET_HOST} ${2}
    echo ""
  fi
done
