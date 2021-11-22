#!/bin/sh

OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')

xrandr --output $OUTPUT --mode 1200x1920 --panning 800x1280 --scale 0.6666x0.6666
#xrandr --output $OUTPUT --mode 1920x1080 --panning 1280x720 --scale 0.6666x0.6666
#xrandr --output $OUTPUT --mode 1920x1080 --panning 1440x810 --scale 0.75x0.75
#xrandr --output $OUTPUT --mode 1920x1200 --panning 1440x900 --scale 0.75x0.75

# this is needed as for some reason the above command gives an error, but still does what it should
exit 0
