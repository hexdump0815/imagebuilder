#!/bin/sh

OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')

xrandr --output $OUTPUT --mode 1200x1920 --panning 800x1280 --scale 0.6666x0.6666

# this is needed as for some reason the above command gives an error, but still does what it should
exit 0
