#!/bin/bash

T=2

output(){
    W="$1"
    if [ -z "$W" ]
    then
        echo "Please, look outside..."
    else
        echo "$W"
    fi
}


weather() {
    FORMAT=3
    #    FORMAT=4
    #    FORMAT="%l:+%c+🌡️ %t+🌫️ %h+🌬️ %w+🌧️ %o"
    #    FORMAT="%25l:+%25c+%F0%9F%8C%A1%EF%B8%8F%25t+%F0%9F%8C%AB%EF%B8%8F%25h+%F0%9F%8C%AC%EF%B8%8F%25w+%F0%9F%8C%A7%EF%B8%8F%25o%0A"

    if ! ping -c1 wttr.in > /dev/null 2>&1
    then
        echo ""
        return
    fi
    if [ $T -eq 0 ]; then
        W=$(curl -s "https://wttr.in?format=$FORMAT" 2>/dev/null | grep -v "Unknown location")

        output "$W"

    elif [ $T -eq 1 ]; then
        W=$(curl -s "https://wttr.in/San Lorenzo in Campo?format=$FORMAT" 2>/dev/null | grep -v "Unknown location")

        output "$W"

    else
        W=$(curl -s "https://wttr.in/Bologna?format=$FORMAT" 2>/dev/null | grep -v "Unknown location")

        output "$W"
    fi
}

toggle() {
    T=$(((T + 1) % 3))
    kill -15 $(pgrep --oldest --parent $$) > /dev/null 2>&1
}

trap "toggle" USR1

echo $$ >> /tmp/.weather_pid

while true; do
    weather
    sleep 3600 &
    wait
done


