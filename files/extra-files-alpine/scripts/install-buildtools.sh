#!/bin/bash

apk update
apk add build-base flex bison meson ninja-build samurai cmake autoconf automake libtool pkgconf openssl-dev ncurses-dev pciutils-dev memtester sysstat flashrom gettext libelf podman podman-docker libtraceevent python3-dev
