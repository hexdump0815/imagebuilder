#!/bin/bash

apt-get update
apt-get -y install build-essential flex bison meson ninja-build cmake autoconf automake libtool pkg-config libssl-dev libncurses-dev libpci-dev memtester sysstat flashrom gettext libelf-dev podman podman-docker
