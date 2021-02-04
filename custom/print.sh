#!/bin/bash
#

conf=$HOME/.config/i3-scrot.conf

scrot_dir="$HOME/Screenshot"

help_func(){
    echo "
available options:
-s | --screen  full screen
-w | --window  active window
-a | --area    area selection
-h | --help    display this information

The file destination can be set in ${conf}.
Default is $scrot_dir
"
}


if [ -f $conf ]; then
    source $conf
fi


if ! [ -d $scrot_dir ]; then
    mkdir -p $scrot_dir
fi

case "$1" in
    -s|--screen)
        cd $scrot_dir
        scrot &&
            sleep 1 &&
            notify-send "Screenshot of screen" "Saved in $scrot_dir"
        ;;
    -w|--window)
        cd $scrot_dir
        scrot -u &&
            sleep 1 &&
            notify-send "Screenshot of windows" "Saved in $scrot_dir"
        ;;
    -a|--area)
        cd $scrot_dir
        notify-send "Select an area for the screenshot" -u low &
        scrot -f -s &&
            sleep 1 && 
            notify-send "Screenshot of area" "Saved in $scrot_dir"
        ;;
     -h|--help)
        help_func
        ;;
     *)
        help_func
        exit 2
 esac

exit 0
