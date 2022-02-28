#!/bin/bash

# unload bt modules
rmmod btmrvl_sdio
rmmod btmrvl
rmmod btsdio
sleep 1
# unload the wifi module
rmmod mwifiex_sdio
sleep 1
# load the wifi module
modprobe mwifiex_sdio
# load bt modules
modprobe btsdio
modprobe btmrvl
modprobe btmrvl_sdio
