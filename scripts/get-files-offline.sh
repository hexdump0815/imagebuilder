#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

export OFFLINE_DIR=/compile/local/imagebuilder-offline

# check if the given arch matches the supported arch for the selected system
if [ ${2} != $(cat systems/$1/arch.txt) ]; then
  echo ""
  echo "the target arch ${2} is not supported for the selected system (supported is: $(cat systems/$1/arch.txt)) - giving up"
  echo ""
  exit 1
fi

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
  echo ""
  echo "- getting files for $i:" 
  echo ""
  # set DOWNLOAD_DIR to OFFLINE_DIR
  export DOWNLOAD_DIR=${OFFLINE_DIR}
  . systems/$i/get-files.sh
  echo ""
done
