#!/bin/bash

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_min_freq 2> /dev/null | wc -l` -gt 0 ]; then
    echo "available min cpu frequencies:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_min_freq
fi

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_max_freq 2> /dev/null | wc -l` -gt 0 ]; then
    echo "available max cpu frequencies:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_max_freq
fi

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_available_frequencies 2> /dev/null | wc -l` -gt 0 ]; then
    echo "all available cpu frequencies:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_available_frequencies
fi

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_boost_frequencies 2> /dev/null | wc -l` -gt 0 ]; then
    echo "all available cpu boost frequencies:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_boost_frequencies
fi

if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then
    echo -n "boost setting: "
    cat /sys/devices/system/cpu/cpufreq/boost
fi

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_available_governors 2> /dev/null | wc -l` -gt 0 ]; then
    echo "available cpu governors:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_available_governors
fi

if [ `ls /sys/devices/system/cpu/cpu?/cpufreq/scaling_governor 2> /dev/null | wc -l` -gt 0 ]; then
    echo "governor:in use:"
    cat /sys/devices/system/cpu/cpu?/cpufreq/scaling_governor
fi
