#!/bin/bash

T=0

weather() {
    if [ $T -eq 0 ]; then
        curl -s "wttr.in?format=4"
    elif [ $T -eq 1 ]; then
        curl -s "wttr.in/San Lorenzo in Campo?format=4"
    else
        curl -s "wttr.in/Bologna?format=4"
    fi
}

toggle() {
    T=$(((T + 1) % 3))
}

trap "toggle" USR1

#echo $$ > /tmp/weather_pid

while true; do
    weather
    sleep 3600 &
    wait
done


