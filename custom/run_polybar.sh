#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

rm /tmp/.weather_pid >/dev/null 2>&1
rm /tmp/.outputaudio_pid >/dev/null 2>&1

PRIMARY=$(xrandr -q | grep primary | cut -d' ' -f1)
export DEFAULT_INTERFACE=$(ip route | grep -e '^default' | awk '{print $5}' | head -n1)
export ETH_INTERFACE=$(cat /proc/net/dev | grep -e '^en' | cut -d: -f1 | head -n1)
export WLAN_INTERFACE=$(cat /proc/net/dev | grep -e '^wl' | cut -d: -f1 | head -n1)

# Launch Polybar, using default config location ~/.config/polybar/config

if [[ $(polybar -m | wc -l) == 1 && $(xrandr -q | grep " connected" | wc -l) > 1 ]]
then
    m=$(polybar -m | cut -d: -f1)
    EXTEND=false MONITOR=$m polybar bottom >/dev/null 2>&1 &
    EXTEND=false MONITOR=$m polybar top >/dev/null 2>&1 &

else

    for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
        if [ "$m" = "$PRIMARY" ] ; then
            MONITOR=$m polybar bottom >/dev/null 2>&1 &
            MONITOR=$m polybar top >/dev/null 2>&1 &
            echo
        else
            MONITOR=$m polybar bottom2 >/dev/null 2>&1 &
#            MONITOR=$m polybar top2 >/dev/null 2>&1 &
            echo
        fi
    done

fi
