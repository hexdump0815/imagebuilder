#!/bin/bash

apt-get -y remove --purge a2jmidid qjackctl pulseaudio-module-jack

apt-get -y auto-remove
