#!/bin/sh

OUTPUT=$(xrandr | grep "connected primary" | awk '{print $1}')

# example for lenovo duet - kukui krane
xrandr --output $OUTPUT --mode 1200x1920 --panning 800x1280 --scale 0.6666x0.6666
# examples for a 16:9 full hd screen
#xrandr --output $OUTPUT --mode 1920x1080 --panning 1280x720 --scale 0.6666x0.6666
#xrandr --output $OUTPUT --mode 1920x1080 --panning 1440x810 --scale 0.75x0.75
# example for a 16:10 full hd screen
#xrandr --output $OUTPUT --mode 1920x1200 --panning 1440x900 --scale 0.75x0.75
# examples for moto g4 play - harpia
#xrandr --output $OUTPUT --mode 720x1280 --panning 432x768 --scale 0.6x0.6
#xrandr --output $OUTPUT --mode 720x1280 --panning 540x960 --scale 0.75x0.75

# important: if display scaling is used in combination with a rotated touch screen
# then it might be required to adjust the values in the coordinate transformation
# matrix in /etc/udev/rules.d/90-android-touch-dev.rules to for example:
# ENV{ID_INPUT_TOUCHSCREEN}=="1", \
# ENV{LIBINPUT_CALIBRATION_MATRIX}="0 1 0 -0.5 0 0.5"
# to get the touch screen working properly

# this is needed as for some reason the above command gives an error, but still does what it should
exit 0
