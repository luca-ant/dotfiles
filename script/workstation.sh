#! /bin/bash

if [ $# -ne 1 ];
then
    echo "Usage: $0 [ kill | start ]"
    exit 1
fi

kill_all(){

    for i in {1..8}
    do
        i3-input -F "[workspace=$i] kill" -P "kill workspace $i"
    done
}


start_all(){
    # browser
    i3-msg "workspace 1; exec $BROWSER"
    sleep 2

    # terminal
    i3-msg "workspace 2; exec $TERMINAL"
    sleep 1

    # browser
    #i3-msg "workspace 3; exec $BROWSER"
    #sleep 2

    # visual studio code
    i3-msg "workspace 3; exec code"
    sleep 2

    # browser
    i3-msg "workspace 4; exec $BROWSER"
    sleep 2

    # terminal
    i3-msg "workspace 5; exec $TERMINAL"
    sleep 1
    i3-msg "workspace 6; exec $TERMINAL"
    sleep 1

    # spotify
    #i3-msg "workspace 8; exec spotify"
    #sleep 1

}


#move this windows to ws9
i3-msg move container to workspace 9

if [ "$1" == "kill" ]
then
    kill_all
    exit 0

elif [ "$1" == "start" ]
then
    kill_all
    start_all
    exit 0
fi
