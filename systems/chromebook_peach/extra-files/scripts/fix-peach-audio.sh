#!/bin/bash

# TODO: unclear if this is really required on peach as well - testing required
# work around the broken alsa naming
ASOUND_SHORT_NAME=`cat /proc/asound/cards | awk '{print $3}' | head -n 1`
ASOUND_LONG_NAME=`cat /proc/asound/cards | awk '{print $5}' | head -n 1`
if [ "${ASOUND_SHORT_NAME}" != "" ] && [ "${ASOUND_LONG_NAME}" != "" ]; then
  rm -rf /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}
  cp -r /usr/share/alsa/ucm2/${ASOUND_LONG_NAME} /usr/share/alsa/ucm2/${ASOUND_SHORT_NAME}
fi
