#!/bin/bash

# unload bt modules
rmmod btmrvl_sdio
rmmod btmrvl
sleep 1
# unload the wifi module
rmmod mwifiex_sdio
sleep 1
# load the wifi module
modprobe mwifiex_sdio
# load bt modules
modprobe btmrvl
modprobe btmrvl_sdio
