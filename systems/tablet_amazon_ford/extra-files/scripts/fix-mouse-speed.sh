#!/bin/bash

# find the mouse
MOUSE_ID=`xinput list | grep -i mouse | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`

for i in $MOUSE_ID; do
  xinput set-prop $i "Coordinate Transformation Matrix" 30 0 0 0 30 0 0 0 1
done
