#!/bin/bash

# for some reason apparmor did not work properly and delyed the bootup quite a bit - so lets disable it for now
systemctl disable apparmor.service
