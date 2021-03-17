#!/bin/bash


display_output_audio(){
    O=$(pacmd list-sinks | grep -e 'active port' | awk -F":" '{print $2}' | head -n1 | sed 's/>//g' | sed 's/<//g' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    if [[ $O == *"headphones"* ]]
    then
        echo '🎧'
    elif [[ $O == *"speaker"* ]]
    then
        echo '🎵'
    else
        echo "❌"
    fi
}

toggle() {

    CURRENT_OUTPUT_PORT=$(pacmd list-sinks | grep -e 'active port' | awk -F":" '{print $2}' | head -n1 | sed 's/>//g' | sed 's/<//g' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

    if [ $CURRENT_OUTPUT_PORT == "analog-output-speaker" ]
    then
pacmd set-sink-port 0 analog-output-headphones
    elif [ $CURRENT_OUTPUT_PORT == "analog-output-headphones" ]
    then
pacmd set-sink-port 0 analog-output-speaker
    fi

    kill -15 $(pgrep --oldest --parent $$) > /dev/null 2>&1
}

trap "toggle" USR1

echo $$ >> /tmp/.outputaudio_pid
echo $$
while true; do
    display_output_audio
    sleep infinity &
    wait
done
