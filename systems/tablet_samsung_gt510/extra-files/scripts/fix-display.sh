#!/bin/sh

xrandr --display :0 --output DSI-1 --off
# the short sleep seems to be required with newer kernels ...
sleep 1
xrandr --display :0 --output DSI-1 --auto --rotate right
# in case the display is not rotated
#xrandr --display :0 --output DSI-1 --auto
