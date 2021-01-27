#!/bin/bash
# 
# the legacy u-boot of the amlogic s8xx can only handle files up to 23 char length
# so we have shorten some filenames to be on the safe side with the version appended
#

cd $(dirname $0)
for i in uImage-* ; do
  NEWNAME=$(echo $i | sed 's,uImage-,uIm-,g')
  mv -v $i $NEWNAME
done
for i in uInitrd-* ; do
  NEWNAME=$(echo $i | sed 's,uInitrd-,uIn-,g')
  mv -v $i $NEWNAME
done
