#!/bin/sh

OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')

# the samsung gt510 might need this to get rid of some display corruption
#xrandr --output $OUTPUT --off
# the short sleep seems to be required with newer kernels ...
#sleep 1
#xrandr --output $OUTPUT --auto --rotate right
# in case the display is not rotated
#xrandr --output $OUTPUT --auto

# this is needed as sometimes an above command gives an error, but still does what it should
exit 0
