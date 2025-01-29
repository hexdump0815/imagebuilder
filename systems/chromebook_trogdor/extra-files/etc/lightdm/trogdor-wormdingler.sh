#!/bin/bash

# landscape mode and scale down the display to 1500x900
xrandr --output DSI-1 --mode 1200x2000 --panning 900x1500 --scale 0.75x0.75 --rotate left

# find the touch screen input
TOUCH_ID=`xinput list | grep "hid-over-i2c 0603:604A" | grep pointer | grep -v Eraser | sed 's,.*id=,,g' | awk '{print $1}'`

# see https://linuxhint.com/rotate-screen-in-raspberry-pi/ for possible transformations
# do not ask where the 0.6 is coming from, but this value scales the y axis properly
xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" 0 -1 1 0.6 0 0 0 0 1

# this is needed as sometimes an above command gives an error, but still does what it should
exit 0
