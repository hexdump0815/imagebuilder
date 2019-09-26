#!/bin/bash

echo ""
echo "resizing root filesystem"
echo ""

ROOTDEVICE=$(mount | grep 'on / type' | awk '{print $1}' | sed 's,^/dev/,,g')
ROOTPARTUUID=$(blkid | grep "/dev/$ROOTDEVICE" | awk '{print $5}' | sed 's,",,g' | awk -F= '{print $2}')

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

PARTITIONTYPE=$(fdisk -l /dev/${ROOTDEVICEBASE} | grep "Disklabel type" | awk -F: '{print $2}' | sed 's,^ ,,g')

if [ "$PARTITIONTYPE" = "dos" ]; then
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
elif [ "$PARTITIONTYPE" = "gpt" ]; then
  ROOTPARTITIONSTART=$(sfdisk -d /dev/$ROOTDEVICEBASE | grep $ROOTDEVICE | awk '{print $4}' | sed 's/,//g')
  fdisk /dev/$ROOTDEVICEBASE << EOF
d
$ROOTDEVICEPARTNUMBER
n
$ROOTDEVICEPARTNUMBER
$ROOTPARTITIONSTART

x
u
$ROOTDEVICEPARTNUMBER
$ROOTPARTUUID
r
p
w

EOF
fi

resize2fs /dev/$ROOTDEVICE
