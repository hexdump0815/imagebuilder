#!/bin/bash

echo "# required for working pulseaudio on snow" >> /etc/pulse/deafult.pa
echo "load-module module-alsa-sink device=sysdefault
