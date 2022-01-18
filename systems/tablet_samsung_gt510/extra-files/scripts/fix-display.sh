#!/bin/sh

xrandr --display :0 --output DSI-1 --off
xrandr --display :0 --output DSI-1 --auto
# in case the display is rotated
#xrandr --display :0 --output DSI-1 --auto --rotate right
