#!/bin/bash

while true; do
  date
  if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
    echo -n "temp: "
    cat /sys/class/thermal/thermal_zone0/temp
  fi
  if [ -f /sys/class/thermal/thermal_zone1/temp ]; then
    echo -n "temp: "
    cat /sys/class/thermal/thermal_zone1/temp
  fi
  if [ -f /sys/class/thermal/thermal_zone2/temp ]; then
    echo -n "temp: "
    cat /sys/class/thermal/thermal_zone2/temp
  fi
  if [ -f /sys/class/hwmon/hwmon0/temp1_input ]; then
    echo -n "temp: "
    cat /sys/class/hwmon/hwmon0/temp1_input
  fi
  if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
    echo "cpu frequencies:" 
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_cur_freq 
  fi
  sleep 15
done
