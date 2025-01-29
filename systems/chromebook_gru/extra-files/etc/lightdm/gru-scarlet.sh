#!/bin/bash

# landscape mode and scale down the display to 1280x960
xrandr --output DSI-1 --mode 1536x2048 --panning 960x1280 --scale 0.625x0.625 --rotate left

# find the touch screen input
TOUCH_ID=`xinput list | grep "Elan Touchscreen" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`
# find the pen input
PEN_ID=`xinput list | grep "Stylus Pen" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`

# see https://linuxhint.com/rotate-screen-in-raspberry-pi/ for possible transformations
# do not ask where the 0.75 is coming from, but this value scales the y axis properly
xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" 0 -1 1 0.75 0 0 0 0 1
xinput set-prop $PEN_ID "Coordinate Transformation Matrix" 0 -1 1 0.75 0 0 0 0 1

# this is needed as sometimes an above command gives an error, but still does what it should
exit 0
