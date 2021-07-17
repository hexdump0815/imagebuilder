#!/bin/bash

cd `dirname $0`/..
export WORKDIR=`pwd`

. scripts/args-and-arch-check-functions.sh

export DOWNLOAD_DIR=/compile/local/imagebuilder-download
export OFFLINE_DIR=/compile/local/imagebuilder-offline

if [ "${2}" = "armv7l" ] || [ "${2}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
fi

if [ "${2}" = "i686" ] || [ "${2}" = "x86_64" ]; then
  POSSIBLE_TARGET_HOST="x86_64"
fi

# check if the given arch matches the supported arch for the selected system
if [ $(cat systems/$1/arch.txt) != ${2} ] || [ $(cat systems/$1/arch.txt) != ${POSSIBLE_TARGET_HOST} ]; then
  echo ""
  echo "the target arch ${2} is supported for the selected system - moving on"
  echo ""
else
  echo ""
  echo "the target arch ${2} is not supported for the selected system - giving up"
  echo ""
  exit 1
fi

if [ -d ${DOWNLOAD_DIR} ]; then
  echo ""
  echo "selected: ${1} - ${2} - ${3}"
  echo ""
  CURRENT_SYSTEM=$(cat ${DOWNLOAD_DIR}/system.txt)
  CURRENT_ARCH=$(cat ${DOWNLOAD_DIR}/arch.txt)
  CURRENT_RELEASE=$(cat ${DOWNLOAD_DIR}/release.txt)
  echo "existing download dir ${DOWNLOAD_DIR} is for: ${CURRENT_SYSTEM} - ${CURRENT_ARCH} - ${CURRENT_RELEASE}"
  echo ""
  if [ "${1}" = ${CURRENT_SYSTEM} ] && \
     [ "${2}" = ${CURRENT_ARCH} ] && \
     [ "${3}" = ${CURRENT_RELEASE} ]; then
    echo "both are matching!"
    echo "reusing the existing DOWNLOAD_DIR ${DOWNLOAD_DIR}"
    echo ""
    exit 0
  else
    echo "both are not matching!"
    echo "please delete the DOWNLOAD_DIR ${DOWNLOAD_DIR} first to be able to create a new different one"
    echo ""
    exit 1
  fi
fi

# create downloads dir
mkdir -p ${DOWNLOAD_DIR}

# exit on errors
set -e

# get version information for below
. scripts/versions.conf

# note down selected system, arch and release in the download dir
echo ${1} > ${DOWNLOAD_DIR}/system.txt
echo ${2} > ${DOWNLOAD_DIR}/arch.txt
echo ${3} > ${DOWNLOAD_DIR}/release.txt

if [ -d ${OFFLINE_DIR} ]; then
  # if an offline dir exists just copy the files for the selected system from there instead of downloading them
  echo ""
  echo "offline dir detected - just taking the files from there"
  echo ""
  cp -rv ${OFFLINE_DIR}/*${1}* ${DOWNLOAD_DIR}
else
  # run the get-files.sh script for the selected system
  echo ""
  echo "no offline dir detected - downloading the files required"
  echo ""
  . systems/$1/get-files.sh
fi
