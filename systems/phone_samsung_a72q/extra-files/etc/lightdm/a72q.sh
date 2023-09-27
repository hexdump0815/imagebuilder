#!/bin/bash

# this would rotate the screen to landscape mode if desired
#OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')
#xrandr --output $OUTPUT --mode 1080x2400 --pos 0x0 --rotate right
#TOUCH_ID=`xinput list | grep "stmfts" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`
#xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
