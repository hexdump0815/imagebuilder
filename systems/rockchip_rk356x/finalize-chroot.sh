#!/bin/bash

# rewrite the x96 x6 bootblocks as they contain some efi partition info which
# seems to be expected somehow by the legacy bootloader on the x96 x6 box - it
# looks like this efi partition info gets overwritten when the new partition
# table gets created via fdisk in create-image.sh
dd if=/boot/extra/boot-x96_x6.dd of=/dev/loop0 bs=512 seek=1 skip=1
