#!/bin/bash

if [ $EUID = 0 ] ; then
    echo "You are root! Please, run me as normal user!"
    exit 1
fi


ALL_MONITORS=()

for m in $(xrandr -q | grep "connected" | cut -d" " -f1); do
    ALL_MONITORS+=( "$m" )
done


if [ $# == 1 ]
then

    if [ $1 = "sanlore" ]
    then

        xrandr --output ${ALL_MONITORS[0]} --primary --mode 1920x1080 --output ${ALL_MONITORS[1]} --mode 1920x1080 --left-of ${ALL_MONITORS[0]}

        feh --no-fehbg --bg-fill ~/background.jpg
        #    nitrogen --set-tiled ~/background.jpg

    elif [ $1 = "bolo" ]
    then

        xrandr --output ${ALL_MONITORS[0]} --primary --mode 1920x1080 --output ${ALL_MONITORS[1]} --mode 1920x1080 --left-of ${ALL_MONITORS[0]}

        feh --no-fehbg --bg-fill ~/background.jpg
        #    nitrogen --set-tiled ~/background.jpg

    elif [ $1 = "mono" ]
    then

        xrandr --output ${ALL_MONITORS[0]} --primary --mode 1920x1080 --pos 0x0 --rotate normal --output ${ALL_MONITORS[1]} --off

        feh --no-fehbg --bg-fill ~/background.jpg
        #    nitrogen --set-tiled ~/background.jpg

    elif [ $1 = "mirror" ]
    then

        xrandr --output ${ALL_MONITORS[0]} --primary --mode 1920x1080 --output ${ALL_MONITORS[1]} --mode 1920x1080 --same-as ${ALL_MONITORS[0]}

        feh --no-fehbg --bg-fill ~/background.jpg
        #    nitrogen --set-tiled ~/background.jpg
    fi

else

    echo "Usage: $0 [ mono | mirror | sanlore | bolo ]"
    echo "AUTODISCOVER MONITORS..."

    MONITORS=()
    for m in $(xrandr -q | grep " connected" | cut -d" " -f1); do
        MONITORS+=( "$m" )
    done

    echo DONE!

    XRANDR_CMD="xrandr --output ${MONITORS[0]} --primary --mode 1920x1080"

    for i in "${!MONITORS[@]}"; do
        if [[ "$i" == 0 ]]; then
            continue
        fi
        j=$(expr $i -1 )
        $XRANDR_CMD="${XRANDR_CMD} --output ${MONITORS[$i]} --mode 1920x1080 --left-of ${ALL_MONITORS[$j]}"
    done
    $XRANDR_CMD
    feh --no-fehbg --bg-fill ~/background.jpg
    #    nitrogen --set-tiled ~/background.jpg
fi


if which polybar >/dev/null 2>&1
then
    "$DOTFILES_ROOT/custom/run_polybar.sh" >/dev/null 2>&1

fi

if which polybar-git >/dev/null 2>&1
then
    "$DOTFILES_ROOT/custom/run_polybar.sh" >/dev/null 2>&1

fi
