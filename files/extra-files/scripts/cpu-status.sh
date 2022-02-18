#!/bin/bash

while true; do
  date
  for i in $(find /sys/class/thermal/thermal_zone*/temp 2> /dev/null); do
    echo -n "zone $(echo $i | sed 's,/sys/class/thermal/thermal_zone,,g;s,/temp,,g') temp: "
    cat $i
  done
  for i in $(find /sys/class/hwmon/hwmon*/temp*_input 2> /dev/null); do
    echo -n "hwmon $(echo $i | sed 's,/sys/class/hwmon/hwmon,,g;s,temp,,g;s,_input,,g') temp: "
    cat $i
  done
  if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
    echo "cpu frequencies:" 
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_cur_freq 
  fi
  sleep 15
done
