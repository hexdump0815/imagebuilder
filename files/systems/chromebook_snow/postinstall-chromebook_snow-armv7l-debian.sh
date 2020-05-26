#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on snow - audio input does not yet work well" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=sysdefault" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=sysdefault" >> etc/pulse/default.pa
