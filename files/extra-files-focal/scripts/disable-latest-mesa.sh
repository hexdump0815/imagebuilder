#!/bin/bash

apt-get -y install ppa-purge
ppa-purge ppa:oibaf/graphics-drivers
apt-get update
apt-get dist-upgrade
