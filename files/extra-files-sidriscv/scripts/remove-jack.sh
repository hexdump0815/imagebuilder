#!/bin/bash

apt-get -y remove --purge qjackctl pulseaudio-module-jack

apt-get -y auto-remove
