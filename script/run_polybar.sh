#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

rm /tmp/weather_pid >/dev/null 2>&1

PRIMARY=$(xrandr -q | grep primary | cut -d' ' -f1)
export DEFAULT_INTERFACE=$(ip route | grep -e '^default' | awk '{print $5}' | head -n1)
export ETH_INTERFACE=$(cat /proc/net/dev | grep -e '^en' | cut -d: -f1 | head -n1)
export WLAN_INTERFACE=$(cat /proc/net/dev | grep -e '^wl' | cut -d: -f1 | head -n1)

# Launch Polybar, using default config location ~/.config/polybar/config


for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
    if [ "$m" = "$PRIMARY" ] ; then
        MONITOR=$m polybar bottom &
        MONITOR=$m polybar top &
    else
        MONITOR=$m polybar bottom &
        MONITOR=$m polybar extra &
    fi
done
