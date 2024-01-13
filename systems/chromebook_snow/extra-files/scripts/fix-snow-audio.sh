#!/bin/bash

# work around the broken alsa naming
ASOUND_SHORT_NAME=`cat /proc/asound/cards | awk '{print $3}' | head -n 1`
ASOUND_LONG_NAME=`cat /proc/asound/cards | awk '{print $5}' | head -n 1`
if [ "${ASOUND_SHORT_NAME}" != "" ] && [ "${ASOUND_LONG_NAME}" != "" ]; then
  rm -rf /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}
  cp -r /usr/share/alsa/ucm2/${ASOUND_LONG_NAME} /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}
fi

# this is to make debian happy too
mkdir -p /usr/share/alsa/ucm2/Samsung/snow
cp /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}/HiFi.conf /usr/share/alsa/ucm2/Samsung/snow/HiFi.conf
cp /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}/HiFi.conf /usr/share/alsa/ucm2/Samsung/snow/HiFi.conf.working
