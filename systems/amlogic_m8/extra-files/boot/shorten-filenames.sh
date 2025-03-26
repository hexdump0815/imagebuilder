#!/bin/bash
# 
# the legacy u-boot of the amlogic s8xx can only handle files up to 23 char length
# so we have shorten some filenames to be on the safe side with the version appended
#
# TODO: this should actually be adjusted, so that it will rebuild the uInitrd from
#       the initramfs image before shortening the filenames, so that an updated
#       initramfs actually gets used as on this platform the uInitrd is used and
#       not the initramfs image

cd $(dirname $0)
for i in uImage-* ; do
  NEWNAME=$(echo $i | sed 's,uImage-,uIm-,g')
  mv -v $i $NEWNAME
done
for i in uInitrd-* ; do
  NEWNAME=$(echo $i | sed 's,uInitrd-,uIn-,g')
  mv -v $i $NEWNAME
done
