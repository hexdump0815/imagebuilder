#!/bin/bash

# landscape mode
xrandr --output DSI-1 --rotate right

# find the touch screen
TOUCH_ID=`xinput list | grep "Goodix Capacitive TouchScreen" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`

# rotating the touch screen coordinates
xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
