#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

export DOWNLOAD_DIR=/compile/local/imagebuilder-downloads

if [ -d ${DOWNLOAD_DIR} ]; then
  echo ""
  read -p "DOWNLOAD_DIR ${DOWNLOAD_DIR} already exists - do you want to reuse it (y/n)? " -n 1 -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi
  echo ""
fi

# create downloads dir
mkdir -p ${DOWNLOAD_DIR}

# exit on errors
set -e

# get version information for below
. scripts/versions.conf

# check if the given arch matches the supported arch for the selected system
if [ ${2} != $(cat systems/$1/arch.txt) ]; then
  echo ""
  echo "the target arch ${2} is not supported for the selected system (supported is: $(cat systems/$1/arch.txt)) - giving up"
  echo ""
  exit 1
fi

# run the get-files.sh script for the selected system
. systems/$1/get-files.sh
