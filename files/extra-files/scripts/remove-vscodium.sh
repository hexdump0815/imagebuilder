#!/bin/bash

apt-get -y remove --purge codium
rm -f /etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
rm -f /etc/apt/sources.list.d/vscodium.list
apt-get update
