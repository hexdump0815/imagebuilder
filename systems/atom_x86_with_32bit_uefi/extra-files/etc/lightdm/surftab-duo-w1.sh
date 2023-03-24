#!/bin/bash

# find the touch screen
TOUCH_ID=`xinput list | grep "Goodix Capacitive TouchScreen" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`

# swap the touchscreen cursor x axis
xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" -1 0 1 0 1 0 0 0 1

exit 0
