#!/bin/bash

# write the special boot header at the beginning of the disk back as
# it seems to get overwritten when creating the partitions with fdisk
dd if=/boot/extra/boot-bpi-f3-armbian.dd of=/dev/loop0 bs=1 count=68
