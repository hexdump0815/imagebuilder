#!/bin/bash

echo ""
echo "resizing root filesystem"
echo ""

ROOTDEVICE=$(mount | grep 'on / type' | awk '{print $1}' | sed 's,^/dev/,,g')

ROOTDEVICEBASE=$(echo $ROOTDEVICE | grep "mmcblk" | sed 's,p.*,,g')
ROOTDEVICEPARTNUMBER=$(echo $ROOTDEVICE | sed 's,mmcblk.p,,g')
# the above is for the mmcblkx case - below is for the sdx case
if [ "$ROOTDEVICEBASE" = "" ]; then
  ROOTDEVICEBASE=$(echo $ROOTDEVICE | grep "sd" | head -c 3)
  ROOTDEVICEPARTNUMBER=$(echo $ROOTDEVICE | sed 's,sd.,,g')
fi
# in case we cannot determine the root device base
if [ "$ROOTDEVICEBASE" = "" ]; then
  echo ""
  echo "cannot determine the root device base - giving up"
  echo ""
  exit 1
fi

ROOTPARTITIONSTART=$(sfdisk -d /dev/$ROOTDEVICEBASE | grep $ROOTDEVICE | awk '{print $4}' | sed 's/,//g')

fdisk /dev/$ROOTDEVICEBASE << EOF
d
$ROOTDEVICEPARTNUMBER
n
p
$ROOTDEVICEPARTNUMBER
$ROOTPARTITIONSTART

p
w

EOF

resize2fs /dev/$ROOTDEVICE
