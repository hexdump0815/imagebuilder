#!/bin/bash

# landscape mode
xrandr --output DSI-1 --mode 800x1280 --pos 0x0 --rotate right

# find the touch screen
TOUCH_ID=`xinput list | grep "Goodix Capacitive TouchScreen" | grep pointer | sed 's,.*id=,,g' | awk '{print $1}'`

# rotating the touch screen coordinates is not done this way anymore ...
#xinput set-int-prop $TOUCH_ID "Evdev Axes Swap" 8 0
#xinput set-int-prop $TOUCH_ID "Evdev Axis Inversion" 8 1, 1

# ... but this way instead now
xinput set-prop $TOUCH_ID "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1

exit 0
