#!/bin/sh
#
# IMPORTANT: as this script is being run as part of the rootfs cache
#            creation the rootfs cache has to be deleted after each
#            change in this script so that it gets recreated properly

export LANG=C

apk update
apk add --allow-untrusted cfdisk sudo bash p7zip btrfs-progs btrfs-compsize zstd

rm -rf /bootstrap
