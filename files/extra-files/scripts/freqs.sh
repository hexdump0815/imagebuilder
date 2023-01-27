#!/bin/bash

if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ]; then
    echo "available min cpu frequencies:" 
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_min_freq
fi

if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq ]; then
    echo "available max cpu frequencies:" 
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_max_freq
fi

if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies ]; then
    echo "all available cpu frequencies:" 
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_available_frequencies
fi

if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors ]; then
    echo "available cpu governors:" 
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
fi
