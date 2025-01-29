#!/bin/sh

OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')

# this is required to properly initialize the display (just noise otherwise)
# this might scrictly only be required on the samsung galaxy book go (not sure right now)
xrandr --output $OUTPUT --off
xrandr --output $OUTPUT --auto

# this is needed as sometimes an above command gives an error, but still does what it should
exit 0
