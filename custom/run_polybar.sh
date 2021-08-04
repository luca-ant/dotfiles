#!/bin/bash

COMMAND=''

if which polybar > /dev/null 2>&1
then
    COMMAND='polybar'
    CFG='-c ~/.config/polybar/config'
elif which polybar-git > /dev/null 2>&1
then
    COMMAND='polybar-git'
    CFG='-c ~/.config/polybar/config'
fi

if [ -z "$COMMAND" ]
then
    echo "polybar not found" >&2
    exit 1
fi

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

if [[ $($COMMAND -m | wc -l) == 1 && $(xrandr -q | grep " connected" | wc -l) > 1 ]]
then
    m=$($COMMAND -m | cut -d: -f1)
    EXTEND=false MONITOR=$m $COMMAND $CFG bottom >/dev/null 2>&1 &
    EXTEND=false MONITOR=$m $COMMAND $CFG top >/dev/null 2>&1 &

else

    for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
        if [ "$m" = "$PRIMARY" ] ; then
            MONITOR=$m $COMMAND -c ~/.config/polybar/config bottom >/dev/null 2>&1 &
            MONITOR=$m $COMMAND -c ~/.config/polybar/config top >/dev/null 2>&1 &
            echo
        else
            MONITOR=$m $COMMAND -c ~/.config/polybar/config bottom2 >/dev/null 2>&1 &
#            MONITOR=$m $COMMAND -c ~/.config/polybar/config$CFG top2 >/dev/null 2>&1 &
            echo
        fi
    done

fi
